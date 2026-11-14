import 'package:flutter/material.dart';
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
    email: 'ubaydillah@example.com',
    hp: '081234567890',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            tooltip: 'Edit profil',
            icon: const Icon(Icons.edit),
            onPressed: _edit,
          ),
        ],
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
        ],
      ),
    );
  }
}