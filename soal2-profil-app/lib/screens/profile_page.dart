import 'package:flutter/material.dart';

import '../main.dart';
import '../models/profile.dart';
import '../widgets/info_tile.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile _profile = const Profile(
    nama: 'Muhammad Ubaydillah',
    nim: '1124160011',
    prodi: 'Teknik Informatika',
    kelas: 'A',
    bio: 'Mahasiswa yang sedang belajar pemrograman mobile dengan Flutter.',
    email: '1124160011@global.ac.id',
    hp: '089634007972',
    github: 'MUHAMADUBAYDILAH605',
  );

  Future<void> _edit() async {
    final result = await Navigator.push<Profile>(
      context,
      MaterialPageRoute(builder: (_) => EditProfilePage(profile: _profile)),
    );
    if (result != null) {
      setState(() => _profile = result);
    }
  }

  void _setDark(bool dark) {
    themeNotifier.value = dark ? ThemeMode.dark : ThemeMode.light;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            tooltip: 'Mode gelap',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => _setDark(!isDark),
          ),
          IconButton(
            tooltip: 'Tentang saya',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
          IconButton(
            tooltip: 'Edit profil',
            icon: const Icon(Icons.edit),
            onPressed: _edit,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_profile.nama),
              accountEmail: Text(_profile.email),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/foto.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang Saya'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              value: isDark,
              onChanged: _setDark,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _edit,
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 64,
              backgroundImage: AssetImage('assets/images/foto.jpg'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _profile.nama,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text('NIM ${_profile.nim}', textAlign: TextAlign.center),
          Text(
            '${_profile.prodi} • Kelas ${_profile.kelas}',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_profile.bio, textAlign: TextAlign.center),
          ),
          InfoTile(icon: Icons.email, title: 'Email', value: _profile.email),
          InfoTile(icon: Icons.phone, title: 'No. HP', value: _profile.hp),
          InfoTile(icon: Icons.code, title: 'GitHub', value: _profile.github),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
