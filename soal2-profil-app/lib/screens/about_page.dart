import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Saya')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Keahlian & Hobi', style: titleStyle),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text('Pemrograman Flutter'),
                ),
                ListTile(
                  leading: Icon(Icons.web),
                  title: Text('Pengembangan Web (PHP)'),
                ),
                ListTile(
                  leading: Icon(Icons.sports_esports),
                  title: Text('Bermain Game'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Riwayat Pendidikan', style: titleStyle),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [           
                ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text('S1 Teknik Informatika'),
                  subtitle: Text('Global Institute, 2024 - sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}