import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/feature_flags.dart';
import '../../app/providers.dart';
import '../../data/repositories/export_repository.dart';
import '../../data/repositories/settings_repository.dart';

class SettingsState {
  const SettingsState({
    required this.currency,
    required this.keepLastCategory,
    required this.flags,
  });

  final String currency;
  final bool keepLastCategory;
  final FeatureFlags flags;

  SettingsState copyWith({
    String? currency,
    bool? keepLastCategory,
    FeatureFlags? flags,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
      keepLastCategory: keepLastCategory ?? this.keepLastCategory,
      flags: flags ?? this.flags,
    );
  }
}

class SettingsController extends AsyncNotifier<SettingsState> {
  SettingsController();

  @override
  Future<SettingsState> build() async {
    final repo = ref.read(settingsRepositoryProvider);
    final flagsRepo = ref.read(featureFlagsRepositoryProvider);
    final currency = await repo.loadCurrency();
    final keepLast = await repo.loadKeepLastCategory();
    final flags = await flagsRepo.load();
    return SettingsState(currency: currency, keepLastCategory: keepLast, flags: flags);
  }

  Future<void> updateCurrency(String currency) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.saveCurrency(currency);
    state = AsyncData(state.value!.copyWith(currency: currency));
  }

  Future<void> updateKeepLastCategory(bool value) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.saveKeepLastCategory(value);
    state = AsyncData(state.value!.copyWith(keepLastCategory: value));
  }

  Future<void> exportCsv() async {
    final exportRepo = ref.read(exportRepositoryProvider);
    final rows = await exportRepo.loadAll();
    final data = <List<dynamic>>[
      [
        'id',
        'amount_cents',
        'currency',
        'occurred_at_iso',
        'category_id',
        'category_name',
        'merchant',
        'note',
        'source',
        'created_at_iso',
        'updated_at_iso',
        'deleted_at_iso',
      ],
      ...rows.map((row) => [
            row.id,
            row.amountCents,
            row.currency,
            row.occurredAtIso,
            row.categoryId,
            row.categoryName,
            row.merchant ?? '',
            row.note ?? '',
            row.source,
            row.createdAtIso,
            row.updatedAtIso,
            row.deletedAtIso ?? '',
          ]),
    ];
    final csvData = const ListToCsvConverter().convert(data);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/expenses_export.csv');
    await file.writeAsString(csvData);
    await Share.shareXFiles([XFile(file.path)], text: 'Export spese');
  }
}

final settingsControllerProvider = AsyncNotifierProvider<SettingsController, SettingsState>(SettingsController.new);
