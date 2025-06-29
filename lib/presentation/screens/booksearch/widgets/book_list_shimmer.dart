import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BookListShimmer extends StatelessWidget {
  const BookListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Column(
        children: List.generate(6, (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: 1.5.h),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                leading: Container(width: 50, height: 60, color: Colors.white),
                title: Container(
                    width: double.infinity, height: 10, color: Colors.white),
                subtitle:
                    Container(width: 150, height: 10, color: Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
