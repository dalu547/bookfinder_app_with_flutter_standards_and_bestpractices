import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/domain/core/failure.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';
import 'package:bookfinder/domain/usecases/book_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'usecase_mock_helper.mocks.dart';

void main() {
  late MockBookLibraryRepository mockRepository;
  late BookDetailsUseCase useCase;

  const testOlid = 'OL123456M';
  final testInput = BookDetailsUseCaseInput(testOlid);

  final testBookDetail = BookDetailEntity(
    publisher: 'Reilly Media',
    publishDate: '2023',
    numberOfPages: 420,
    olid: testOlid,
  );

  setUp(() {
    mockRepository = MockBookLibraryRepository();
    useCase = BookDetailsUseCase(mockRepository);
  });

  group('BookDetailsUseCase', () {
    test('returns BookDetailEntity from DB if available', () async {
      when(mockRepository.getBookDetailsFromDB(testOlid))
          .thenAnswer((_) async => testBookDetail);

      final result = await useCase.execute(testInput);

      expect(result, Right(testBookDetail));
      verify(mockRepository.getBookDetailsFromDB(testOlid));
      verifyNever(mockRepository.fetchBookDetails(any));
    });

    test('fetches from API and caches when local data is missing', () async {
      when(mockRepository.getBookDetailsFromDB(testOlid))
          .thenThrow(Exception("No Cache"));
      when(mockRepository.fetchBookDetails(testOlid))
          .thenAnswer((_) async => Right(testBookDetail));

      final result = await useCase.execute(testInput);

      expect(result, Right(testBookDetail));
      verify(mockRepository.fetchBookDetails(testOlid));
      verify(mockRepository.insertBookDetailsToDB(testBookDetail));
    });

    test('returns error when both local and API fail', () async {
      final error = Failure.noInternet(AppStrings.noInternet);

      when(mockRepository.getBookDetailsFromDB(testOlid))
          .thenThrow(Exception("No Cache"));
      when(mockRepository.fetchBookDetails(testOlid))
          .thenAnswer((_) async => Left(error));

      final result = await useCase.execute(testInput);

      expect(result, Left(error));
      verify(mockRepository.fetchBookDetails(testOlid));
      verifyNever(mockRepository.insertBookDetailsToDB(any));
    });
  });
}
