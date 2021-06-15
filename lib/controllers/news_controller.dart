import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/base_state/base_state.dart';
import 'package:news_app_riverpod/models/top_headlines.dart';
import 'package:news_app_riverpod/repositories/news_repository.dart';

/**register controller similar to dependency injection in bloc */
final newsController = StateNotifierProvider.autoDispose((ref) {
  ref.onDispose(() {});
  return NewsController(ref.read);
});

class NewsController extends BaseNotifier<TopHeadlines> {
  NewsController(
    this._read,
  ) : super(state: const BaseState.initial());

  final Reader _read;
/**similar to inject<get> in bloc */
  INewsRepository get _getNews => _read(newsRepository);
  Future<void> fetchNews() async {
    state = const BaseState.loading();

    final response = await _getNews.getNews();
    state = response.fold((message) => BaseState.success(data: message),
        (error) => BaseState.error(error));
  }
}
