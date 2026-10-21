import 'package:flutter/material.dart';
import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2
  bool _nouveautesSeulement = false;

  // Q3.3 : les 5 genres, tous cochés au départ
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  // Q3.4 : icône par genre
  final Map<String, IconData> _icones = {
    'Roman': Icons.menu_book,
    'Science': Icons.science,
    'Histoire': Icons.history_edu,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  // Q3.6 : état de la case « Tous les genres » (true / false / null)
  bool? get _tousLesGenres {
    if (_genres.values.every((v) => v)) return true;
    if (_genres.values.every((v) => !v)) return false;
    return null;
  }

  // Q3.7 : livres filtrés par genres cochés (et nouveautés si demandé)
  List get _livresFiltres {
    return livres.where((l) {
      final genreOk = _genres[l.genre] ?? false;
      final nouveauteOk = !_nouveautesSeulement || l.nouveaute;
      return genreOk && nouveauteOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final affiches = _livresFiltres;
    final nbLus = affiches.where((l) => l.lu).length;

    return Scaffold(
      appBar: AppBar(
        // Q3.8 : compteur dynamique
        title: Text('Lus : $nbLus / ${affiches.length}'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Q3.2 : filtre nouveautés
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              setState(() {
                _nouveautesSeulement = valeur!;
              });
            },
          ),
          const Divider(),

          // Q3.6 : case tristate « Tous les genres »
          CheckboxListTile(
            title: const Text(
              'Tous les genres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tristate: true,
            value: _tousLesGenres,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.indigo,
            onChanged: (valeur) {
              setState(() {
                // Un clic coche tout, sauf si tout est déjà coché
                final nouvelle = _tousLesGenres != true;
                for (final g in _genres.keys) {
                  _genres[g] = nouvelle;
                }
              });
            },
          ),

          // Q3.3 + Q3.4 : un CheckboxListTile par genre
          ..._genres.keys.map((genre) {
            final nb = livres.where((l) => l.genre == genre).length;
            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nb livre${nb > 1 ? 's' : ''}'),
              secondary: Icon(_icones[genre]),
              activeColor: Colors.teal,
              // Q3.5 : leading = case à gauche
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (valeur) {
                setState(() {
                  _genres[genre] = valeur!;
                });
              },
            );
          }),

          const Divider(thickness: 2),

          // Q3.7 : liste des livres filtrés
          ListView.separated(
            // La liste est dans un ListView parent : shrinkWrap + pas de scroll propre
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: affiches.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final livre = affiches[index];
              return CheckboxListTile(
                value: livre.lu,
                controlAffinity: ListTileControlAffinity.leading,
                secondary: CircleAvatar(
                  backgroundColor: livre.couleur,
                  child: Text(
                    livre.titre[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    decoration:
                        livre.lu ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(livre.auteur),
                onChanged: (valeur) {
                  setState(() {
                    livre.lu = valeur!;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}