import 'package:newsapp/models/news_article.dart';

abstract interface class FavoriteNewsDao {
  Future<List<NewsArticle>> getFavoriteNews();

  Future<void> addFavoriteNews(NewsArticle favoriteNews);

  Future<void> removeFavoriteNews(NewsArticle newsArticle);

  Future<void> clearFavoriteNews();

  Future<bool> isFavoriteNews(NewsArticle newsArticle);
}
