import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/widgets/news_foru.dart';
import 'package:news_app/widgets/textfield.dart';
import '../controller/newController.dart';
import '../model/news_model.dart';
import 'newsDetail.dart';

class ArticalPage extends StatelessWidget {
  const ArticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Article",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Textfield(),
              const SizedBox(height: 20),
              Obx(() {
                if (newsController.NewsArticalList.isEmpty && newsController.isNewsLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
          
                if (newsController.NewsArticalList.isEmpty) {
                  return const Center(child: Text("No news available"));
                }
          
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsController.NewsArticalList.length,
                  itemBuilder: (context, index) {
                    final article = newsController.NewsArticalList[index];
          
                    return NewsForu(
                      imageUrl: article.urlToImage,
                      author: article.author ?? "Unknown",
                      title: article.title,
                      time: article.publishedAt,
                      onTap: () {
                        Get.to(NewsDetail(article: article));
                      },
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
