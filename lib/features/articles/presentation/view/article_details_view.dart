import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/services/notification_service.dart';


class ArticleDetailsView extends StatelessWidget {
  final String title;
  final String? thumbnail;
  final String? paragraphs;

  const ArticleDetailsView({
    super.key,
    required this.title,
    this.thumbnail,
    this.paragraphs,
  });

  @override
  Widget build(BuildContext context) {
    final parsedParagraphs = paragraphs != null
        ? List<Map<String, dynamic>>.from(jsonDecode(paragraphs!))
        : [];

    // NotificationService.instance.showNotification(
    //   title: 'اضافة مقال',
    //   body: 'تمت اضافة مقال جديد: $title',
    // );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ✅ صورة المقال
            if (thumbnail != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  thumbnail!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
                ),
              ),

            const SizedBox(height: 16),

            // ✅ عنوان المقال
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // ✅ عرض الفقرات
            ...parsedParagraphs.map((p) {
              final images = (p['images'] ?? []) as List;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (p['title'] != null)
                    Text(
                      p['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (p['content'] != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        p['content'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                  // ✅ عرض الصور كـ ListView
                  if (images.isNotEmpty)
                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final imageUrl = images[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              width: 240,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
