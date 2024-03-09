import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/clients/news_api_client.dart';
import 'package:newsapp/providers.dart';

import '../models/news_article.dart';
import 'news_detail_screen.dart';

class FavoriteNewsListScreen extends ConsumerWidget {
  const FavoriteNewsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsList = ref.watch(favoriteNewsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your favorite news'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              ref.read(favoriteNewsProvider.notifier).clearFavoriteNews();
            },
          ),
        ],
      ),
      body: switch (newsList) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final article = value[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    article.title ?? 'No title',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: article.description != null
                      ? Text(article.description!)
                      : const SizedBox(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailScreen(article: article),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        AsyncError(:final error) =>
          Text('Oops, something unexpected happened, error: $error'),
        _ => const Center(
            child: CircularProgressIndicator(),
          )
      },
    );
  }
}
