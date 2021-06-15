import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/failures/failure.dart';
import 'package:news_app_riverpod/models/top_headlines.dart';

final newsRepository = Provider<INewsRepository>((ref) {
  return NewsRepository(ref.read);
});

abstract class INewsRepository {
  Future<Either<TopHeadlines, Failure>> getNews();
}

class NewsRepository implements INewsRepository {
  NewsRepository(this._read);
  final Reader _read;
  final Dio _dio = Dio();
  @override
  Future<Either<TopHeadlines, Failure>> getNews() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=61a99634846e4eaa9e22e83114fea66e');

      final result = TopHeadlines.fromJson(response.data!);
      return Left(result);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }
}
