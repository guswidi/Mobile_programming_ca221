import 'package:flutter/material.dart';
import 'api_service.dart';
import 'news_detail.dart';  // Import halaman detail berita

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> newsFeed = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fungsi untuk mengambil data berita dari API
  Future<void> fetchData() async {
    try {
      final feed = await ApiService.fetchNewsBySection('Business');
      setState(() {
        newsFeed = feed;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsFeed.length,
              itemBuilder: (context, index) {
                final newsItem = newsFeed[index];
                return ListTile(
                  leading: newsItem['og'] != null
                      ? Image.network(newsItem['og'], width: 50, height: 50, fit: BoxFit.cover)
                      : null,
                  title: Text(newsItem['title'] ?? 'No Title'),
                  subtitle: Text(newsItem['source'] ?? 'Unknown Source'),
                  onTap: () {
                    // Navigasi ke halaman detail berita
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(
                          title: newsItem['title'] ?? 'No Title',
                          link: newsItem['link'],
                          source: newsItem['source'] ?? 'Unknown Source',
                          image: newsItem['og'],
                          content: newsItem['content'] ?? 'No content available.',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
