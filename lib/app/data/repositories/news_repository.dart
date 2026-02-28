import '../models/article_model.dart';
import '../providers/news_provider.dart';

class NewsRepository {
  final NewsProvider provider;

  NewsRepository(this.provider);

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await provider.getTopHeadlines();

    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List articles = response.body['articles'];
      return articles.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<Article>> fetchByCategory(String category) async {
    final response = await provider.getNewsByCategory(category: category);

    if (response.statusCode == 200) {
      final List articles = response.body['articles'];
      return articles.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load category news');
    }
  }

  Future<List<Article>> searchNews(String query) async {
    final response = await provider.searchNews(query: query);

    if (response.statusCode == 200) {
      final List articles = response.body['articles'];
      return articles.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search news');
    }
  }
}
