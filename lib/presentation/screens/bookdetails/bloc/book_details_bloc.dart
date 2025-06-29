import 'package:bloc/bloc.dart';
import 'package:bookfinder/domain/usecases/book_details_usecase.dart';
import 'package:bookfinder/presentation/screens/bookdetails/bloc/book_details_event.dart';
import 'package:bookfinder/presentation/screens/bookdetails/bloc/book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final BookDetailsUseCase _bookDetailsUseCase;

  BookDetailsBloc(this._bookDetailsUseCase) : super(BookDetailsInitial()) {
    on<GetBookDetails>(_onGetBookDetails);
  }

  Future<void> _onGetBookDetails(
    GetBookDetails event,
    Emitter<BookDetailsState> emit,
  ) async {
    emit(BookDetailsLoading());

    final input = BookDetailsUseCaseInput(event.olid);
    final result = await _bookDetailsUseCase.execute(input);

    result.fold(
      (error) => emit(BookDetailsFailure(error)),
      (data) => emit(BookDetailsSuccess(data)),
    );
  }
}
