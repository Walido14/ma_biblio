import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              subtitle: const Text('Nom, e-mail, mot de passe'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil sélectionné')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              tileColor: Colors.blue.shade50,
              iconColor: Colors.blueAccent,
              textColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.language),
              title: Text('Langue'),
              subtitle: Text('Français'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              subtitle: const Text('MaBiblio version 1.0\nTP Flutter'),
             
              onTap: () {},
            ),
          ],
        ).toList(),
      ),
    );
  }
}