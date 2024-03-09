import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends ConsumerStatefulWidget {
  const NewsListScreen({super.key});

  @override
  ConsumerState<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends ConsumerState<NewsListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // newListProvider
    final newsList = ref.watch(newListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hottest News Today!'),
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
