import 'package:newsapp/models/news_article.dart';

abstract interface class NewsDao {
  Future<List<NewsArticle>> getNews();
}
