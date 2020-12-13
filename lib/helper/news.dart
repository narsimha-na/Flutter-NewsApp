import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  String url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=517ba599d3cb405b8bc15204de9c6f64";

  Future<void> getNews() async {
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((item){
        if(item["urlToImage"] != null && item["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title:item["title"],
            author: item["author"],
            description: item["description"],
            url: item["url"],
            urlToImage: item["urlToImage"],
            publishedAt: item["publishedAt"],
            content: item["content"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}
