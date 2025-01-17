import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  final String title;
  final String link;
  final String source;
  final String? image;
  final String content;

  // Konstruktor untuk menerima data berita
  NewsDetail({
    required this.title,
    required this.link,
    required this.source,
    this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar berita jika ada
              if (image != null)
                Image.network(
                  image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 10),
              
              // Menampilkan judul berita
              Text(
                title,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, height: 1.5),
              ),
              SizedBox(height: 10),
              
              // Menampilkan sumber berita
              Text(
                'Sumber: $source',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              
              // Menampilkan isi berita lengkap
              Text(
                content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Tombol untuk membuka link berita di browser
              ElevatedButton(
                onPressed: () async {
                  // Membuka link berita di browser menggunakan url_launcher
                  if (await canLaunch(link)) {
                    await launch(link);
                  } else {
                    throw 'Tidak bisa membuka $link';
                  }
                },
                child: Text('Baca Selengkapnya di Browser'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
