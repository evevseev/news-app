import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/clients/news_api_client.dart';
import 'package:newsapp/dao/favorite_news_dao.dart';
import 'package:newsapp/dao/favorite_news_shared_preferences_dao.dart';
import 'package:newsapp/dao/news_api_dao.dart';
import 'package:newsapp/models/news_article.dart';
import 'package:newsapp/repositories/favorite_news_repository.dart';

import 'dao/news_dao.dart';

final Provider<FavoriteNewsDao> favoriteNewsDaoProvider =
    Provider<FavoriteNewsDao>(
  (ref) {
    return FavoriteNewsSharedPreferencesDao();
  },
);

final Provider<FavoriteNewsRepository> favoriteNewsRepositoryProvider =
    Provider<FavoriteNewsRepository>(
  (ref) {
    final favoriteNewsProvider = ref.read(favoriteNewsDaoProvider);
    return FavoriteNewsRepository(favoriteNewsProvider);
  },
);

final Provider<NewsDao> newsDaoProvider = Provider<NewsDao>(
  (ref) {
    return NewsApiDao(NewsApiClient(
        baseUrl: dotenv.env['NEWS_API_BASE_URL']!,
        apiKey: dotenv.env['NEWS_API_KEY']!));
  },
);

final newListProvider = FutureProvider.autoDispose((ref) async {
  final newsDao = ref.read(newsDaoProvider);
  return newsDao.getNews();
});

final favoriteNewsProvider =
    AsyncNotifierProvider.autoDispose<FavoriteNews, List<NewsArticle>>(
        FavoriteNews.new);

class FavoriteNews extends AutoDisposeAsyncNotifier<List<NewsArticle>> {
  final FavoriteNewsRepository _favoriteNewsRepository = FavoriteNewsRepository(
    FavoriteNewsSharedPreferencesDao(),
  );

  @override
  Future<List<NewsArticle>> build() async {
    return await _favoriteNewsRepository.getFavoriteNews();
  }

  Future<void> addFavoriteNews(NewsArticle newsArticle) async {
    await _favoriteNewsRepository.addFavoriteNews(newsArticle);
    ref.invalidateSelf();
    await future;
  }

  Future<void> removeFavoriteNews(NewsArticle newsArticle) async {
    await _favoriteNewsRepository.removeFavoriteNews(newsArticle);
    ref.invalidateSelf();
    await future;
  }

  Future<void> clearFavoriteNews() async {
    await _favoriteNewsRepository.clearFavoriteNews();
    ref.invalidateSelf();
    await future;
  }
}
