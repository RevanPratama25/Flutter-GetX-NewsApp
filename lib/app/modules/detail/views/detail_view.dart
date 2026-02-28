import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/article_model.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFF0E1117),
      body: Stack(
        children: [
          // HERO IMAGE
          if (article.imageUrl != null)
            Hero(
              tag: article.url,
              child: Image.network(
                article.imageUrl!,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          // GRADIENT OVER IMAGE
          Container(
            height: 320,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF0E1117).withOpacity(0.95),
                ],
              ),
            ),
          ),

          // CONTENT
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 280,
              left: 16,
              right: 16,
              bottom: 100, // 🔑 ruang buat tombol bawah
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(height: 1.3),
                ),
                const SizedBox(height: 12),
                Text(
                  article.description ?? 'No description available.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // APPBAR OVERLAY
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),

          // 🔥 STICKY READ MORE BUTTON
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    'Read More',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F6FEB),
                    foregroundColor: Colors.white, // 🔑 FIX VISIBILITY
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final uri = Uri.parse(article.url);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    )) {
                      Get.snackbar('Error', 'Could not open article');
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
