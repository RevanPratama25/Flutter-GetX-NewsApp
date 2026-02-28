import 'package:get/get.dart';
import 'package:news_app_2nd/app/data/repositories/news_repository.dart';
import '../../../data/models/article_model.dart';

class HomeController extends GetxController {
  final NewsRepository repository;

  HomeController(this.repository);

  final isLoading = true.obs;
  final articles = <Article>[].obs;

  // List of news categories
  final List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  final selectedCategory = 'General'.obs;

  void fetchByCategory() async {
    try {
      isLoading.value = true;
      articles.value = await repository.fetchByCategory(selectedCategory.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchByCategory();
    super.onInit();
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    fetchTopHeadlines();
  }

  final searchQuery = ''.obs;

  Future<void> fetchTopHeadlines() async {
    try {
      isLoading.value = true;
      articles.value = await repository.fetchByCategory(selectedCategory.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news');
    } finally {
      isLoading.value = false;
    }
  }
}
