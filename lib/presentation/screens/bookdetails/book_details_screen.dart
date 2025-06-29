import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/presentation/screens/bookdetails/widgets/book_detail_info.dart';
import 'package:bookfinder/presentation/screens/bookdetails/widgets/book_detail_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookfinder/core/di/app_di.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/presentation/screens/bookdetails/bloc/book_details_bloc.dart';
import 'package:bookfinder/presentation/screens/bookdetails/bloc/book_details_event.dart';
import 'package:bookfinder/presentation/screens/bookdetails/bloc/book_details_state.dart';
import 'package:bookfinder/app/utils/url_utils.dart';

class BookDetailView extends StatefulWidget {
  final BookEntity book;

  const BookDetailView({super.key, required this.book});

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  final detailBloc = instance<BookDetailsBloc>();

  @override
  void initState() {
    super.initState();
    if (widget.book.editionKey.isNotEmpty) {
      detailBloc.add(GetBookDetails(widget.book.editionKey));
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final imageUrl = getCoverUrl(book.editionKey);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.bookDetailsTitle)),
      body: BlocProvider.value(
        value: detailBloc,
        child: BlocBuilder<BookDetailsBloc, BookDetailsState>(
          builder: (context, state) {
            if (book.editionKey.isEmpty) {
              return BookDetailInfo(
                book: book,
                imageUrl: imageUrl,
                animate: false,
                publisher: AppStrings.notAvailable,
                publishDate: AppStrings.notAvailable,
                pages: AppStrings.notAvailable,
              );
            }

            if (state is BookDetailsLoading) return const BookDetailShimmer();

            if (state is BookDetailsFailure) {
              return Center(child: Text(state.error.message));
            }

            if (state is BookDetailsSuccess) {
              final detail = state.bookDetailEntity;
              return BookDetailInfo(
                book: book,
                imageUrl: imageUrl,
                animate: true,
                publisher: detail.publisher,
                publishDate: detail.publishDate,
                pages: "${detail.numberOfPages}",
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
