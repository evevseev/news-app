import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'news_article.freezed.dart';
part 'news_article.g.dart';


@freezed
class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    // required NewsSource? source,
    required String? author,
    required String? title,
    required String? description,
    required String? url,
    required String? urlToImage,
    required String? publishedAt,
    required String? content,
  }) = _NewsArticle;

  factory NewsArticle.fromJson(Map<String, Object?> json) =>
      _$NewsArticleFromJson(json);
}

//
// class NewsSource {
//
//   const factory NewsSource({
//     required String id,
//     required String name,
//   }) = _NewsSource;
//
//   factory NewsSource.fromJson(Map<String, Object?> json) =>
//       _$NewsSourceFromJson(json);
// }
