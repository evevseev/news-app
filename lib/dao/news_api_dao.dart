import 'package:newsapp/dao/news_dao.dart';
import 'package:newsapp/models/news_article.dart';

import '../clients/news_api_client.dart';

class NewsApiDao implements NewsDao {
  NewsApiDao(this.newsApiClient);

  final NewsApiClient newsApiClient;

  @override
  Future<List<NewsArticle>> getNews() {
    return newsApiClient.fetchNews();
  }
}
