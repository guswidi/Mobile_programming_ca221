import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://ok.surf/api/v1/news-feed';

  // Fungsi untuk mengambil data berita dari API berdasarkan kategori
  static Future<List<dynamic>> fetchNewsBySection(String section) async {
    final response = await http.get(Uri.parse('$apiUrl?sections=$section'));

    if (response.statusCode == 200) {
      // Mengonversi response body menjadi JSON dan mengembalikannya
      final data = json.decode(response.body);
      // Pastikan struktur data sesuai dengan yang diinginkan
      return data[section]?.map((item) {
        // Menambahkan konten berita jika tersedia
        return {
          'title': item['title'],
          'link': item['link'],
          'source': item['source'],
          'og': item['og'],
          'content': item['content'] ?? 'Content not available',  // Ambil konten jika ada
        };
      }).toList() ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
