import 'package:bookfinder/core/network/network_info.dart';
import 'package:bookfinder/data/datasources/local/book_library_local_datasource.dart';
import 'package:bookfinder/data/datasources/remote/book_library_remote_datasource.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  NetworkInfo,
  BookLibraryRemoteDatasource,
  BookLibraryLocalDatasource,
])
void main() {}
