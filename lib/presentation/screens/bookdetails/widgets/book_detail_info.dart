import 'package:bookfinder/presentation/screens/bookdetails/widgets/book_info_row.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/presentation/screens/bookdetails/widgets/book_cover_image.dart';
import 'package:bookfinder/app/resources/app_constants.dart';
import 'package:bookfinder/app/resources/strings_manager.dart';

class BookDetailInfo extends StatelessWidget {
  final BookEntity book;
  final String imageUrl;
  final String publisher;
  final String publishDate;
  final String pages;
  final bool animate;

  const BookDetailInfo({
    super.key,
    required this.book,
    required this.imageUrl,
    required this.publisher,
    required this.publishDate,
    required this.pages,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RotatingNetworkImageWithFallback(
                imageUrl: imageUrl,
                fallbackAsset: AppConstants.fallbackCoverLarge,
                width: AppConstants.coverImageWidth,
                height: AppConstants.coverImageHeight,
                animate: animate,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              book.title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            Text(
              '${AppStrings.bookBy} ${book.author}',
              style: TextStyle(fontSize: 14.sp, fontStyle: FontStyle.italic),
            ),
            Divider(color: Colors.grey.shade400, thickness: 0.8, height: 4.h),
            BookInfoRow(label: AppStrings.publisher, value: publisher),
            BookInfoRow(label: AppStrings.publishedDate, value: publishDate),
            BookInfoRow(label: AppStrings.pages, value: pages),
          ],
        ),
      ),
    );
  }
}
