import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class BookSearchInput extends StatelessWidget {
  final TextEditingController controller;

  const BookSearchInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: AppStrings.searchTitle,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
