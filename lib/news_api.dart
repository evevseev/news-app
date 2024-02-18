import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey = 'e4f8f6738f3e4ca59da4673e8bcf5510';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['articles'];
      return jsonList.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class NewsArticle {
  final NewsSource? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  NewsArticle({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      source:
          json['source'] != null ? NewsSource.fromJson(json['source']) : null,
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class NewsSource {
  final String id;
  final String name;

  NewsSource({required this.id, required this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
    );
  }
}
