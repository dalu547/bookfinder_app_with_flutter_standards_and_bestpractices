import 'package:bookfinder/app/resources/app_constants.dart';
import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/presentation/screens/booksearch/widgets/book_list_shimmer.dart';
import 'package:bookfinder/presentation/screens/booksearch/widgets/book_list_tile.dart';
import 'package:bookfinder/presentation/screens/booksearch/widgets/book_search_input.dart';
import 'package:bookfinder/presentation/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';
import 'package:bookfinder/core/di/app_di.dart';
import 'package:bookfinder/core/network/network_info.dart';
import 'package:bookfinder/app/utils/app_logger.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/presentation/screens/booksearch/bloc/book_search_bloc.dart';
import 'package:bookfinder/presentation/screens/booksearch/bloc/book_search_event.dart';
import 'package:bookfinder/presentation/screens/booksearch/bloc/book_search_state.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  final bookBloc = instance<BookSearchBloc>();
  final NetworkInfo networkInfo = instance<NetworkInfo>();

  final TextEditingController _searchController = TextEditingController();
  final Debouncer debouncer = Debouncer();
  final PagingController<int, BookEntity> _pagingController =
      PagingController(firstPageKey: 1);

  String currentQuery = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkInternetAndShowSnackBar(context, networkInfo);
    });

    _pagingController.addPageRequestListener((pageKey) {
      if (currentQuery.isNotEmpty) {
        AppLogger.debug("Fetching page $pageKey for query $currentQuery");
        bookBloc.add(SearchBook(currentQuery, AppConstants.defaultSearchFields,
            pageKey, AppConstants.pageSize));
      }
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    if (query == currentQuery) return;

    debouncer.debounce(
      duration: AppConstants.debounceDuration,
      onDebounce: () {
        setState(() => currentQuery = query);
        _pagingController.refresh();

        if (query.isNotEmpty) {
          FocusScope.of(context).unfocus();

          // Optional: If you want to eagerly call notifyPageRequestListeners
          Future.microtask(() => _pagingController
              .notifyPageRequestListeners(_pagingController.firstPageKey));
        }
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(AppStrings.bookSearchTitle),
            automaticallyImplyLeading: false),
        body: BlocProvider<BookSearchBloc>(
          create: (_) => bookBloc,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                BookSearchInput(
                  controller: _searchController,
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: BlocListener<BookSearchBloc, BookSearchState>(
                    listener: _handleState,
                    child: currentQuery.isEmpty
                        ? const Center(
                            child: Text(AppStrings.startTypingMessage))
                        : RefreshIndicator(
                            onRefresh: () async => _pagingController.refresh(),
                            child: PagedListView.separated(
                              pagingController: _pagingController,
                              separatorBuilder: (_, __) => Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.grey[500]),
                              builderDelegate:
                                  PagedChildBuilderDelegate<BookEntity>(
                                itemBuilder: (context, book, index) =>
                                    BookListTile(book: book),
                                firstPageProgressIndicatorBuilder: (_) =>
                                    const BookListShimmer(),
                                newPageProgressIndicatorBuilder: (_) =>
                                    const Center(
                                        child: CircularProgressIndicator()),
                                noItemsFoundIndicatorBuilder: (_) =>
                                    const Center(
                                        child: Text(
                                            AppStrings.noBooksFoundMessage)),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, BookSearchState state) {
    if (state is BookSearchSuccess) {
      final isLastPage = state.books.length < AppConstants.pageSize;
      final nextPageKey = _pagingController.nextPageKey ?? 1;

      if (isLastPage) {
        _pagingController.appendLastPage(state.books);
      } else {
        _pagingController.appendPage(state.books, nextPageKey + 1);
      }
    } else if (state is BookSearchFailure) {
      showAppSnackBar(context, state.error.message, color: Colors.red.shade400);
    }
  }
}
