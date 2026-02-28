import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';



class NewsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(seconds: 20);
    super.onInit();
  }

  Future<Response> getTopHeadlines() {
    return get(
      '/top-headlines',
      query: {'sources': 'techcrunch', 'apiKey': dotenv.env['NEWS_API_KEY']},
    );
  }
  
  Future<Response> searchNews({required String query}) {
    return get(
      '/everything',
      query: {
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': '20',
        'apiKey': dotenv.env['NEWS_API_KEY'],
      },
    );
  }

  Future<Response> getNewsByCategory({required String category}) {
    return get(
      '/top-headlines',
      query: {
        'category': category.toLowerCase(),
        'country': 'us',
        'pageSize': '20',
        'apiKey': dotenv.env['NEWS_API_KEY'],
      },
    );
  }
}
