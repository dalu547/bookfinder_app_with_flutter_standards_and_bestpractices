import 'package:bookfinder/app/resources/app_constants.dart';
import 'package:bookfinder/app/utils/url_utils.dart';
import 'package:flutter/material.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/core/router/routes_manager.dart';
import 'package:bookfinder/presentation/screens/booksearch/widgets/thubmnail_fallback.dart';

class BookListTile extends StatelessWidget {
  final BookEntity book;

  const BookListTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final imageUrl = getThumbnailUrl(book.editionKey);

    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.bookDetails,
          arguments: book,
        );
      },
      leading: NetworkImageWithFallback(
        imageUrl: imageUrl,
        width: AppConstants.coverThumbnailWidth,
        height: AppConstants.coverThumbnailHeight,
        fallbackAsset: AppConstants.fallbackCoverLarge,
      ),
      title: Text(
        book.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
