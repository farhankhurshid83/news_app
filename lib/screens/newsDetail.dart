import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news_model.dart';
import '../controller/newController.dart';

class NewsDetail extends StatelessWidget {
  final NewsArticle article;
  final NewsController newsController = Get.find(); // 🏆 GetX Controller Instance

  NewsDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          Obx(() => IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                newsController.isPlaying.value ? Icons.stop : Icons.volume_up,
                key: ValueKey(newsController.isPlaying.value), // Ensures smooth animation
              ),
            ),
            onPressed: () async {
              if (newsController.isPlaying.value) {
                await newsController.stopReading();
              } else {
                await newsController.readNews(
                    "${article.title}. ${article.description ?? "No description available."}");
              }
            },
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  (article.urlToImage!.isNotEmpty)
                      ? article.urlToImage!
                      : "https://webz.io/wp-content/uploads/2023/01/Competitive-Intelligence-3.jpg",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://webz.io/wp-content/uploads/2023/01/Competitive-Intelligence-3.jpg",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 5),
              Text("By ${article.author ?? 'Unknown'}", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text(article.description ?? "No description available", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 10),
              Text("Published At: ${article.publishedAt}", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),
              Center(
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: newsController.isPlaying.value ? 200 : 180, // Expands when playing
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: newsController.isPlaying.value
                        ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      )
                    ]
                        : [],
                  ),
                  child: ElevatedButton.icon(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        newsController.isPlaying.value ? Icons.stop : Icons.volume_up,
                        key: ValueKey(newsController.isPlaying.value),
                      ),
                    ),
                    label: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: Text(
                        newsController.isPlaying.value ? "Stop Reading" : "Read News",
                        key: ValueKey(newsController.isPlaying.value),
                      ),
                    ),
                    onPressed: () async {
                      if (newsController.isPlaying.value) {
                        await newsController.stopReading();
                      } else {
                        await newsController.readNews(
                            "${article.title}. ${article.description ?? "No description available."}");
                      }
                    },
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
