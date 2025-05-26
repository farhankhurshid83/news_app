import 'dart:convert';
class NewsArticle {
  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticle({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    String? imageUrl = json['urlToImage'];

    // ✅ Check if image is missing, empty, or invalid
    if (imageUrl == null || imageUrl.isEmpty || Uri.tryParse(imageUrl)?.hasAbsolutePath != true) {
      imageUrl = "https://webz.io/wp-content/uploads/2023/01/Competitive-Intelligence-3.jpg";
    }

    return NewsArticle(
      source: Source.fromJson(json['source'] ?? {}),
      author: json['author'] ?? "Unknown",
      title: json['title'] ?? "No title available",
      description: json['description'] ?? "No description available",
      url: json['url'] ?? "",
      urlToImage: imageUrl, // ✅ Now always has a valid image
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "No content available",
    );
  }






  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

void main() {
  String jsonString = '''
  {
    "source": {
      "id": "techcrunch",
      "name": "TechCrunch"
    },
    "author": "Lauren Forristal",
    "title": "Bye-bye bots: Altera's game-playing AI agents get backing from Eric Schmidt | TechCrunch",
    "description": "Autonomous, AI-based players are coming to a gaming experience near you...",
    "url": "https://techcrunch.com/2024/05/08/bye-bye-bots-alteras-game-playing-ai-agents-get-backing-from-eric-schmidt/",
    "urlToImage": "https://techcrunch.com/wp-content/uploads/2024/05/Minecraft-keyart.jpg?resize=1200,720",
    "publishedAt": "2024-05-08T15:14:57Z",
    "content": "Autonomous, AI-based players are coming..."
  }
  ''';

  Map<String, dynamic> jsonData = json.decode(jsonString);
  NewsArticle article = NewsArticle.fromJson(jsonData);
  print(article.title);
}
