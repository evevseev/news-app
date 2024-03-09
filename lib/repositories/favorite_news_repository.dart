import 'package:newsapp/dao/favorite_news_dao.dart';
import 'package:newsapp/models/news_article.dart';

class FavoriteNewsRepository {
  final FavoriteNewsDao favoriteNewsSource;

  FavoriteNewsRepository(this.favoriteNewsSource);

  Future<List<NewsArticle>> getFavoriteNews() async {
    return favoriteNewsSource.getFavoriteNews();
  }

  Future<void> addFavoriteNews(NewsArticle news) async {
    return favoriteNewsSource.addFavoriteNews(news);
  }

  Future<void> removeFavoriteNews(NewsArticle news) async {
    return favoriteNewsSource.removeFavoriteNews(news);
  }

  Future<void> clearFavoriteNews() async {
    return favoriteNewsSource.clearFavoriteNews();
  }

  Future<bool> isFavoriteNews(NewsArticle news) {
    return favoriteNewsSource.isFavoriteNews(news);
  }
}
