import 'package:bookfinder/presentation/screens/bookdetails/book_details_screen.dart';
import 'package:bookfinder/presentation/screens/booksearch/books_search_screen.dart';
import 'package:bookfinder/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';

class Routes {
  static const String bookList = '/book-list';
  static const String bookDetails = '/book-detail';
  static const String splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case bookList:
        return MaterialPageRoute(builder: (_) => const BookListView());
      case bookDetails:
        final book = settings.arguments as BookEntity;
        return MaterialPageRoute(
          builder: (_) => BookDetailView(book: book),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
