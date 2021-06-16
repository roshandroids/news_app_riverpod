import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/base_state/base_state.dart';
import 'package:news_app_riverpod/models/top_headlines.dart';
import 'package:news_app_riverpod/repositories/news_repository.dart';

//**register controller similar to dependency injection in bloc */
final newsController = StateNotifierProvider.autoDispose((ref) {
  ref.onDispose(() {});
  return NewsController(ref.read);
});

class NewsController extends BaseNotifier<List<Articles>> {
  NewsController(
    this._read,
  ) : super(state: const BaseState.initial());

  final Reader _read;
//**similar to inject<get> in bloc */
  INewsRepository get _getNews => _read(newsRepository);
  Future<void> fetchNews({
    List<Articles>? data,
    String? countryCode,
    int? page,
    int? size,
  }) async {
    state = const BaseState.loading();

    final response = await _getNews.getNews(
      countryCode: countryCode ?? 'us',
      size: size ?? 10,
      page: page ?? 1,
    );
    state = response.fold(
      (message) => BaseState.success(
        data: data == null ? message.articles : data + message.articles,
      ),
      (error) => BaseState.error(
        error,
      ),
    );
  }
}
