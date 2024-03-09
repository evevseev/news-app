import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newsapp/providers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_article.dart';

class NewsDetailScreen extends ConsumerWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteNews = ref.watch(favoriteNewsProvider);
    final favoriteNewsNotifier = ref.read(favoriteNewsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'No title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            Image.network(
              article.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.title != null)
                  Text(
                    article.title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                if (article.publishedAt != null)
                  Text(
                    article.publishedAt!.substring(0, 10),
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 16),
                Text(article.content ?? article.description ?? ''),
                const SizedBox(height: 16),
                Column(children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(article.url!);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: const Text('Read more'),
                    ),
                  ),
                  if (favoriteNews.asData?.value.contains(article) == true)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          favoriteNewsNotifier.removeFavoriteNews(article);
                        },
                        child: const Text('Remove from favorites'),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          favoriteNewsNotifier.addFavoriteNews(article);
                        },
                        child: const Text('Add to favorites'),
                      ),
                    ),
                ]),
                // save button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
