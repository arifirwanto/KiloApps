import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text("Ini halaman Profil", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
