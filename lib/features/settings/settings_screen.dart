import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Impostazioni')),
      body: settingsAsync.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Preferenze', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: settings.currency,
              decoration: const InputDecoration(labelText: 'Valuta'),
              items: const [
                DropdownMenuItem(value: 'EUR', child: Text('EUR')),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.updateCurrency(value);
                }
              },
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Mantieni ultima categoria'),
              value: settings.keepLastCategory,
              onChanged: controller.updateKeepLastCategory,
            ),
            const SizedBox(height: 16),
            Text('Esporta', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: controller.exportCsv,
              icon: const Icon(Icons.download),
              label: const Text('Esporta CSV'),
            ),
            const SizedBox(height: 16),
            Text('Feature flags', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _ReadOnlyFlag(title: 'Offline only', enabled: settings.flags.offlineOnly),
            _ReadOnlyFlag(title: 'Online OCR', enabled: settings.flags.enableOnlineOcr),
            _ReadOnlyFlag(title: 'Online AI categorization', enabled: settings.flags.enableOnlineAi),
            _ReadOnlyFlag(title: 'Family sync', enabled: settings.flags.enableFamilySync),
            const SizedBox(height: 16),
            Text('Gestione', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Categorie'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/categories'),
            ),
            ListTile(
              title: const Text('Roadmap'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/roadmap'),
            ),
            const Divider(height: 32),
            ListTile(
              title: const Text('About / Privacy'),
              subtitle: const Text('Placeholder'),
              onTap: () {},
            ),
          ],
        ),
        error: (err, _) => Center(child: Text('Errore: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ReadOnlyFlag extends StatelessWidget {
  const _ReadOnlyFlag({required this.title, required this.enabled});

  final String title;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(
        enabled ? Icons.lock : Icons.lock_outline,
        color: enabled ? Colors.green : Colors.grey,
      ),
      subtitle: Text(enabled ? 'ON' : 'OFF'),
    );
  }
}
