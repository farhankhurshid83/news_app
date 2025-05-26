import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsController extends GetxController {
  RxList<NewsArticle> trendingNewsList = <NewsArticle>[].obs;
  RxList<NewsArticle> NewsForUList = <NewsArticle>[].obs;
  RxList<NewsArticle> NewsArticalList = <NewsArticle>[].obs;

  RxBool isNewsLoading = false.obs;
  RxBool isPlaying = false.obs; // 🔊 Track TTS state

  final FlutterTts flutterTts = FlutterTts(); // ✅ Singleton instance
  final String apiKey = "e84c82ff61bc4ae3842abd0300496a8e"; // Store API key securely

  @override
  void onInit() {
    super.onInit();
    getTrendingNews();
    getNewsForU();
    getNewsArtical();
    initializeTTS();
  }

  // 🔊 Initialize TTS settings
  Future<void> initializeTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.awaitSpeakCompletion(true); // ✅ Ensure speech completion is detected

    flutterTts.setCompletionHandler(() async {
      isPlaying.value = false;
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
      isPlaying.value = false;
    });
  }

  // 🔊 Function to read news aloud
  Future<void> readNews(String text) async {
    isPlaying.value = true;  // Mark as playing before speaking
    await Future.delayed(Duration(seconds: 1)); // ✅ Give TTS time to initialize
    var result = await flutterTts.speak(text);
    if (result == 1) {
      isPlaying.value = true;  // ✅ Ensure it stays active if successful
    } else {
      isPlaying.value = false; // ❌ Reset if there's an issue
    }
  }

  // 🛑 Stop TTS
  Future<void> stopReading() async {
    await flutterTts.stop();
    isPlaying.value = false;
  }

  Future<void> fetchNews(String url, RxList<NewsArticle> newsList) async {
    try {
      isNewsLoading.value = true;
      final response = await http.get(Uri.parse("$url&apiKey=$apiKey"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> articles = body["articles"];

        newsList.assignAll(articles.map((e) => NewsArticle.fromJson(e)).toList());
      } else {
        Get.snackbar("Error", "Failed to fetch news: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("Error fetching news: $e");
    } finally {
      isNewsLoading.value = false;
    }
  }

  Future<void> getTrendingNews() async {
    const String baseUrl = "https://newsapi.org/v2/top-headlines?sources=techcrunch";
    await fetchNews(baseUrl, trendingNewsList);
  }

  Future<void> getNewsForU() async {
    const String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business";
    await fetchNews(baseUrl, NewsForUList);
  }

  Future<void> getNewsArtical() async {
    const String baseUrl = "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt";
    await fetchNews(baseUrl, NewsArticalList);
  }
}
