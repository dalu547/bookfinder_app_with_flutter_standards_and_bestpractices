import 'package:bloc/bloc.dart';
import 'package:bookfinder/domain/usecases/book_search_usecase.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final BookSearchUseCase bookSearchUseCase;

  BookSearchBloc(this.bookSearchUseCase) : super(BookSearchInitial()) {
    on<SearchBook>(_onSearchBook);
  }

  Future<void> _onSearchBook(
    SearchBook event,
    Emitter<BookSearchState> emit,
  ) async {
    emit(BookSearchLoading());

    final input = BookSearchUseCaseInput(
      event.query,
      event.fields,
      event.page,
      event.limit,
    );

    final result = await bookSearchUseCase(input);

    result.fold(
      (error) => emit(BookSearchFailure(error)),
      (data) => emit(BookSearchSuccess(data)),
    );
  }
}
