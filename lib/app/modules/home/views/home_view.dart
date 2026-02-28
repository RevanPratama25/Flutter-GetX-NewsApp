import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/shimmer_news.dart';
import '../widgets/category_chip.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tech Headlines')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ShimmerNews();
        }

        if (controller.articles.isEmpty) {
          return const Center(
            child: Text(
              'No news available',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Column(
          children: [
            Obx(() {
              return CategoryChips(
                categories: controller.categories,
                selectedCategory: controller.selectedCategory.value,
                onCategorySelected: controller.updateCategory,
              );
            }),

            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.articles.length,
                itemBuilder: (context, index) {
                  final article = controller.articles[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    splashColor: const Color(0xFF1F6FEB).withOpacity(0.15),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.toNamed('/detail', arguments: article);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF1F6FEB).withOpacity(0.25),
                        ),
                      ),
                      clipBehavior:
                          Clip.hardEdge, // 🔑 PENTING: biar image nempel
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          if (article.imageUrl != null)
                            Hero(
                              tag: article.url,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  article.imageUrl!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          // TEXT CONTENT
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.description ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
