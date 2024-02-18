import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_api.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
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
                if (article.url != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: SizedBox(
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
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
