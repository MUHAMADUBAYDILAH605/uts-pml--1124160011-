import 'package:flutter/material.dart';
import '../models/profile.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;
  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nama;
  late final TextEditingController _prodi;
  late final TextEditingController _kelas;
  late final TextEditingController _bio;
  late final TextEditingController _email;
  late final TextEditingController _hp;
  late final TextEditingController _github;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _nama = TextEditingController(text: p.nama);
    _prodi = TextEditingController(text: p.prodi);
    _kelas = TextEditingController(text: p.kelas);
    _bio = TextEditingController(text: p.bio);
    _email = TextEditingController(text: p.email);
    _hp = TextEditingController(text: p.hp);
    _github = TextEditingController(text: p.github);
  }

  @override
  void dispose() {
    for (final c in [_nama, _prodi, _kelas, _bio, _email, _hp, _github]) {
      c.dispose();
    }
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final dataBaru = widget.profile.copyWith(
      nama: _nama.text.trim(),
      prodi: _prodi.text.trim(),
      kelas: _kelas.text.trim(),
      bio: _bio.text.trim(),
      email: _email.text.trim(),
      hp: _hp.text.trim(),
      github: _github.text.trim(),
    );
    Navigator.pop(context, dataBaru);
  }

  Widget _field(
    TextEditingController c,
    String label, {
    String? Function(String?)? validator,
    TextInputType? type,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        keyboardType: type,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nama, 'Nama Lengkap', validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                return null;
              }),
              _field(_prodi, 'Program Studi'),
              _field(_kelas, 'Kelas'),
              _field(_bio, 'Bio', maxLines: 3),
              _field(_email, 'Email', type: TextInputType.emailAddress,
                  validator: (v) {
                final re = RegExp(r'^[\w\.\-]+@[\w\-]+(\.[\w\-]+)+$');
                if (v == null || !re.hasMatch(v.trim())) {
                  return 'Email tidak valid';
                }
                return null;
              }),
              _field(_hp, 'No. HP', type: TextInputType.phone, validator: (v) {
                if (v == null || !RegExp(r'^\d{10,13}$').hasMatch(v.trim())) {
                  return 'Hanya angka, 10-13 digit';
                }
                return null;
              }),
              _field(_github, 'Akun GitHub'),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}