import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/topics/presentation/view/topics_view.dart';

class SliderDrawer extends StatelessWidget {
  const SliderDrawer({super.key});

  Future<List<Map<String, dynamic>>> _getCategories() async {
    final data = await Supabase.instance.client
        .from('categories')
        .select('id, title');
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.centerRight,
              color: Colors.deepPurple,
              child: const Text(
                'التصنيفات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                // textDirection: TextDirection.ltr,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                  }

                  final categories = snapshot.data ?? [];

                  return ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return ListTile(
                        trailing: const Icon(Icons.circle, size: 14, color: Colors.black),
                        title: Text(
                          category['title'],
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          final categoryId = category['id'].toString();

                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TopicsView(categoryId: categoryId),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
