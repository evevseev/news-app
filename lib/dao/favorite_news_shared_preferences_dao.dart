import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/news_article.dart';
import 'favorite_news_dao.dart';

class FavoriteNewsSharedPreferencesDao implements FavoriteNewsDao {
  static const String _favoriteNewsKey = 'favoriteNews';

  @override
  Future<List<NewsArticle>> getFavoriteNews() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNewsJsonList = prefs.getString(_favoriteNewsKey) ?? '[]';
    final List<dynamic> jsonData = json.decode(favoriteNewsJsonList);
    return jsonData.map((e) => NewsArticle.fromJson(e)).toList();
  }

  @override
  Future<void> addFavoriteNews(NewsArticle news) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNews = await getFavoriteNews();

    if (favoriteNews.contains(news)) {
      // TODO: for future — use set
      return;
    }

    favoriteNews.add(news);
    final favoriteNewsJsonList = json.encode(favoriteNews);
    prefs.setString(_favoriteNewsKey, favoriteNewsJsonList);
  }

  @override
  Future<void> removeFavoriteNews(NewsArticle news) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNews = await getFavoriteNews();
    favoriteNews.remove(news);
    final favoriteNewsJsonList = json.encode(favoriteNews);
    prefs.setString(_favoriteNewsKey, favoriteNewsJsonList);
  }

  @override
  Future<void> clearFavoriteNews() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_favoriteNewsKey);
  }

  @override
  Future<bool> isFavoriteNews(NewsArticle newsArticle) {
    // Algos... one day
    return getFavoriteNews().then((value) => value.contains(newsArticle));
  }
}
