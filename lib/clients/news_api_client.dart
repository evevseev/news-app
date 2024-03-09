import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news_article.dart';

class NewsApiClient {
  NewsApiClient({required this.baseUrl, required this.apiKey});

  final String baseUrl;
  final String apiKey;

  Future<List<NewsArticle>> fetchNews() async {
    final url =
        Uri.parse('$baseUrl/v2/top-headlines?country=us&apiKey=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['articles'];
      return jsonList.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
