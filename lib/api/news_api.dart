import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news_article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsApi {
  Future<List<NewsArticle>> fetchNews() async {
    final String apiKey = dotenv.env['NEWS_API_KEY']!;
    final String baseUrl = dotenv.env['NEWS_API_BASE_URL']!;
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
