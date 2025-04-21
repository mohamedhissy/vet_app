import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'article_details_view.dart';

class ArticlesView extends StatelessWidget {
  final String topicId;

  const ArticlesView({super.key, required this.topicId});

  Future<List<Map<String, dynamic>>> _getArticles() async {
    final response = await Supabase.instance.client
        .from('articles')
        .select('id, title, thumbnail, paragraphs')
        .eq('topic_id', topicId);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المقالات'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getArticles(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final articles = snapshot.data!;
            if (articles.isEmpty) {
              return const Center(child: Text('لا توجد مقالات بعد'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                final thumbnail = article['thumbnail'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArticleDetailsView(
                          title: article['title'],
                          thumbnail: thumbnail,
                          paragraphs: article['paragraphs'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          thumbnail != null
                              ? Image.network(
                            thumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) =>
                            const Center(child: Icon(Icons.broken_image)),
                          )
                              : Container(color: Colors.grey[300]),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Text(
                              article['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
