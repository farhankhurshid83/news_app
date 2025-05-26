import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/newsDetail.dart';
import 'package:news_app/widgets/news_foru.dart';
import 'package:news_app/widgets/treanding_card.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/newController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                newsController.getNewsForU();
                newsController.getTrendingNews();
              },
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Trending News Section
              Row(
                children: [
                  Text("Hottest News", style: Theme.of(context).textTheme.bodyLarge),
                  const Spacer(),
                  Text("See All", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              const SizedBox(height: 10),

              // Trending News List with Shimmer Effect
              Obx(() {
                if (newsController.isNewsLoading.value) {
                  return _buildShimmerTrending();
                }

                if (newsController.trendingNewsList.isEmpty) {
                  return const Center(child: Text("No trending news available"));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: newsController.trendingNewsList.map((article) {
                      return TreandingCard(
                        tag: 'Trending',
                        imagurl: article.urlToImage,
                        time: article.publishedAt,
                        auther: article.author ?? "Unknown",
                        title: article.title,
                        onTap: () {
                          Get.to(NewsDetail(article: article));
                        },
                      );
                    }).toList(),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // News For You Section
              Row(
                children: [
                  Text("News For You", style: Theme.of(context).textTheme.bodyLarge),
                  const Spacer(),
                  Text("See All", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              const SizedBox(height: 20),

              // News For You List with Shimmer Effect
              Obx(() {
                if (newsController.isNewsLoading.value) {
                  return _buildShimmerNewsForU();
                }

                if (newsController.NewsForUList.isEmpty) {
                  return const Center(child: Text("No news available"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsController.NewsForUList.length,
                  itemBuilder: (context, index) {
                    final article = newsController.NewsForUList[index];

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
              }),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Shimmer Effect for Trending News
  Widget _buildShimmerTrending() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 Shimmer Effect for News For You List
  Widget _buildShimmerNewsForU() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
