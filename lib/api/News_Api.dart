import 'dart:convert';

import 'package:api/model.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  Map<String, String> headers = {
    'accept': 'application/json',
  };

  Future<List<Article>> fetcharticles(int page) async {
    String news =
        'http://newsapi.org/v2/everything?q=apple&from=2020-04-15&to=2020-04-15&sortBy=popularity&apiKey=a02ad873b1eb419ca854da684c26e5a3&page=' +
            page.toString();
    http.Response response = await http.get(news, headers: headers);

    if (response.statusCode != 200) {
      return null;
    }

    var body = jsonDecode(response.body);
    var jsonArticles = body["articles"];
    List<Article> articles = [];
    for (var item in jsonArticles) {
      articles.add(Article.fromJson(item));
    }

    return articles;
  }
}
