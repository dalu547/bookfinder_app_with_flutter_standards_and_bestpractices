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
        final args = settings.arguments;
        if (args is BookEntity) {
          return MaterialPageRoute(
            builder: (_) => BookDetailView(book: args),
          );
        }
        return _notFoundRoute('Invalid arguments for $bookDetails');

      default:
        return _notFoundRoute('Route not found: ${settings.name}');
    }
  }
}

Route<dynamic> _notFoundRoute(String message) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: Center(child: Text(message)),
    ),
  );
}
