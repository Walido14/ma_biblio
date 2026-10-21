import 'package:flutter/material.dart';
import '../models/livre.dart';

// Q1.7 : un livre sous forme de ListTile
Widget livreTile(Livre livre, {VoidCallback? onTap}) {
  return ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre[0],
        style: const TextStyle(color: Colors.white),
      ),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${livre.note}'),
        const Icon(Icons.star, color: Colors.amber, size: 18),
      ],
    ),
  );
}

// Q4.1 : carte réutilisable
class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Q4.2
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // Q4.3
      shadowColor: Colors.black54,
      color: Colors.white,
      surfaceTintColor: livre.couleur,
      // Q4.5 : l'encre respecte les coins arrondis
      clipBehavior: Clip.antiAlias,
      // Q4.5 : le onTap du ListTile donne l'effet d'encre
      child: livreTile(livre, onTap: onTap),
    );
  }
}