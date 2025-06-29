import 'package:bookfinder/core/base/base_response.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';

class BookDetailModel extends BaseResponse {
  final String olid;
  final String publisher;
  final int numberOfPages;
  final String publishDate;

  BookDetailModel({
    required this.olid,
    required this.publisher,
    required this.numberOfPages,
    required this.publishDate,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    final publishers = json['publishers'];
    final key = json['key']?.toString();

    return BookDetailModel(
      olid: key != null && key.contains('/books/')
          ? key.replaceFirst('/books/', '')
          : 'Unknown',
      publisher: publishers is List && publishers.isNotEmpty
          ? publishers.first.toString()
          : 'Unknown Publisher',
      numberOfPages: json['number_of_pages'] is int
          ? json['number_of_pages']
          : int.tryParse(json['number_of_pages']?.toString() ?? '') ?? 0,
      publishDate: json['publish_date']?.toString() ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'olid': olid,
      'publisher': publisher,
      'number_of_pages': numberOfPages,
      'publish_date': publishDate,
    };
  }

  BookDetailEntity toEntity() {
    return BookDetailEntity(
      olid: olid,
      publisher: publisher,
      numberOfPages: numberOfPages,
      publishDate: publishDate,
    );
  }

  @override
  String toString() {
    return 'BookDetailModel(olid: $olid, publisher: $publisher, numberOfPages: $numberOfPages, publishDate: $publishDate)';
  }
}
