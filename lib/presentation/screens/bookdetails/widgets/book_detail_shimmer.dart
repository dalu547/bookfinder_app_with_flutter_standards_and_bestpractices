import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BookDetailShimmer extends StatelessWidget {
  const BookDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 300,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3.h),
            Container(height: 20, width: 80.w, color: Colors.white),
            SizedBox(height: 1.h),
            Container(height: 16, width: 50.w, color: Colors.white),
            SizedBox(height: 3.h),
            Container(height: 14, width: 90.w, color: Colors.white),
            SizedBox(height: 1.h),
            Container(height: 14, width: 70.w, color: Colors.white),
            SizedBox(height: 1.h),
            Container(height: 14, width: 60.w, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
