import 'package:get/get.dart';
import 'package:news_app_2nd/app/data/providers/news_provider.dart';
import 'package:news_app_2nd/app/data/repositories/news_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsProvider>(() => NewsProvider());

    Get.lazyPut<NewsRepository>(() => NewsRepository(Get.find()));

    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
