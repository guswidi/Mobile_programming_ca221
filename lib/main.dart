import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF25D366),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
        ),
      ),
      home: const WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        elevation: 0.7,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              // Aksi untuk kamera
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Aksi untuk pencarian
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert), // Ikon titik tiga
            onPressed: () {
              // Aksi untuk menu lainnya
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatsTab(),
          StatusTab(),
          CallsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.message, color: Colors.white),
        onPressed: () {
          // Tambahkan aksi ketika tombol ditap
        },
      ),
    );
  }
}

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar nama kontak yang berbeda
    final List<String> contacts = [
      'Gung De',
      'Wira',
      'Agus',
      'Santi',
      'Eva',
      'Bodi',
      'Joni',
      'Muli',
      'Luno',
      'Jack',
    ];

    // Daftar status pesan yang berbeda
    final List<String> messages = [
      'Halo! Apa kabar?',
      'Sedang dalam perjalanan.',
      'Ayo ngumpul malam ini!',
      'Bagaimana ujianmu?',
      'Jangan lupa bawa makanan.',
      'Baru pulang dari gym.',
      'Kapan kita hangout lagi?',
      'Kamu dapat berita terbaru?',
      'Mau nonton film bareng?',
      'Selamat ulang tahun! 🎉',
    ];

    // Daftar waktu yang berbeda
    final List<String> times = [
      '12:00 PM',
      '1:15 PM',
      '3:45 PM',
      '4:30 PM',
      '5:00 PM',
      '6:20 PM',
      '7:00 PM',
      '8:00 PM',
      '9:00 PM',
      '10:00 PM',
    ];

    // Daftar URL gambar profil
    final List<String> profilePics = [
      'https://via.placeholder.com/150/FF5733/FFFFFF?text=A',
      'https://via.placeholder.com/150/33FF57/FFFFFF?text=B',
      'https://via.placeholder.com/150/3357FF/FFFFFF?text=C',
      'https://via.placeholder.com/150/FFFF33/FFFFFF?text=D',
      'https://via.placeholder.com/150/FF33FF/FFFFFF?text=E',
      'https://via.placeholder.com/150/33FFFF/FFFFFF?text=F',
      'https://via.placeholder.com/150/FF8033/FFFFFF?text=G',
      'https://via.placeholder.com/150/33FF80/FFFFFF?text=H',
      'https://via.placeholder.com/150/8033FF/FFFFFF?text=I',
      'https://via.placeholder.com/150/FF3380/FFFFFF?text=J',
    ];

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profilePics[index]), // Gambar profil dari URL
          ),
          title: Text(contacts[index]), // Menggunakan nama dari daftar
          subtitle: Text(messages[index]), // Menggunakan status dari daftar
          trailing: Text(times[index]), // Menggunakan waktu dari daftar
        );
      },
    );
  }
}

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.add, color: Colors.white),
          ),
          title: Text('Status Saya'),
          subtitle: Text('Tap untuk menambahkan status'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Status Kontak 1'),
          subtitle: Text('20 menit yang lalu'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Status Kontak 2'),
          subtitle: Text('1 jam yang lalu'),
        ),
      ],
    );
  }
}

class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: const Text('Panggilan 1'),
          subtitle: const Row(
            children: [
              Icon(Icons.call_made, color: Colors.green, size: 16),
              SizedBox(width: 5),
              Text('Hari ini, 09:00 AM'),
            ],
          ),
          trailing: Icon(Icons.call, color: Theme.of(context).primaryColor),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: const Text('Panggilan 2'),
          subtitle: const Row(
            children: [
              Icon(Icons.call_received, color: Colors.red, size: 16),
              SizedBox(width: 5),
              Text('Kemarin, 08:00 PM'),
            ],
          ),
          trailing: Icon(Icons.videocam, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
