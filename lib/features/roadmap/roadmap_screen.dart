import 'package:flutter/material.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cosa stiamo costruendo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _RoadmapSection(
            icon: '👨‍👩‍👧‍👦',
            title: 'Bilancio condiviso in famiglia',
            description:
                'Stiamo lavorando alla possibilità di creare un “gruppo famiglia” per condividere le spese tra più dispositivi, con sincronizzazione automatica e gestione dei permessi.',
          ),
          _RoadmapSection(
            icon: '🧾',
            title: 'Scansione scontrini e ricevute',
            description:
                'Vogliamo aggiungere la scansione tramite fotocamera per estrarre importi, data, negozio e (dove possibile) i singoli prodotti.',
          ),
          _RoadmapSection(
            icon: '🤖',
            title: 'Categorizzazione intelligente',
            description:
                'L’obiettivo è proporre automaticamente la categoria più corretta (es. cucina, cura persona, trasporti) riducendo al minimo i tap necessari.',
          ),
          _RoadmapSection(
            icon: '🔒',
            title: 'Privacy e controllo',
            description:
                'L’MVP attuale funziona completamente offline. In futuro, quando attiverai i servizi online, useremo un approccio “privacy-first” e ti daremo sempre controllo su cosa viene inviato e perché.',
          ),
          SizedBox(height: 24),
          Text('Hai suggerimenti? Scrivici: (placeholder email)'),
        ],
      ),
    );
  }
}

class _RoadmapSection extends StatelessWidget {
  const _RoadmapSection({
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
