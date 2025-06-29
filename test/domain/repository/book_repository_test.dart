import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/data/models/book_model.dart';
import 'package:bookfinder/data/models/book_response.dart';
import 'package:bookfinder/data/repositories/book_library_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'repository_mock_helper.mocks.dart';

void main() {
  late MockBookLibraryRemoteDatasource mockRemoteDataSource;
  late MockBookLibraryLocalDatasource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late BookLibraryRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockBookLibraryRemoteDatasource();
    mockLocalDataSource = MockBookLibraryLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = BookLibraryRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  const testQuery = 'roman';
  const testFields = 'title,author_name,cover_edition_key';
  const testPage = 1;
  const testLimit = 20;

  final testBookModel = [
    BookModel(
      title: 'Flutter',
      authorNames: ['John Doe'],
      editionKey: 'OL123456M',
    ),
  ];

  final testEntities = testBookModel.map((book) => book.toEntity()).toList();

  final testResponse = BookResponse(books: testBookModel)
    ..status = 200
    ..message = 'OK';

  group('searchBooks', () {
    test('returns list of BookEntity when API call is successful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.searchBooks(
              testQuery, testFields, testPage, testLimit))
          .thenAnswer((_) async => testResponse);

      final result = await repository.searchBooks(
          testQuery, testFields, testPage, testLimit);

      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected success but got error: $error'),
        (books) => expect(books, testEntities),
      );
    });

    test('returns No Internet error when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.searchBooks(
          testQuery, testFields, testPage, testLimit);

      expect(result.isLeft(), true);
      result.fold(
        (error) {
          expect(error.code, -1);
          expect(error.message, AppStrings.noInternet);
        },
        (_) => fail('Expected error but got success'),
      );
    });

    test('returns default error when API throws exception', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.searchBooks(any, any, any, any))
          .thenThrow(Exception('Book search failed'));

      final result = await repository.searchBooks(
          testQuery, testFields, testPage, testLimit);

      expect(result.isLeft(), true);
      result.fold(
        (error) {
          expect(error.message, 'Unexpected error occurred.');
        },
        (_) => fail('Expected error but got success'),
      );
    });
  });
}
