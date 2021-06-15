import 'package:freezed_annotation/freezed_annotation.dart';
part 'top_headlines.freezed.dart';
part 'top_headlines.g.dart';

@freezed
class TopHeadlines with _$TopHeadlines {
  const factory TopHeadlines({
    String? status,
    int? totalResults,
    @Default(<Articles>[]) List<Articles> articles,
  }) = _TopHeadlines;

  factory TopHeadlines.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesFromJson(json);
}

@freezed
class Articles with _$Articles {
  const factory Articles({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) = _Articles;

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
}

@freezed
class Source with _$Source {
  const factory Source({
    String? id,
    String? name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
