import 'package:shared_preferences/shared_preferences.dart';

class FeatureFlags {
  const FeatureFlags({
    required this.offlineOnly,
    required this.enableOnlineOcr,
    required this.enableOnlineAi,
    required this.enableFamilySync,
  });

  final bool offlineOnly;
  final bool enableOnlineOcr;
  final bool enableOnlineAi;
  final bool enableFamilySync;

  FeatureFlags copyWith({
    bool? offlineOnly,
    bool? enableOnlineOcr,
    bool? enableOnlineAi,
    bool? enableFamilySync,
  }) {
    return FeatureFlags(
      offlineOnly: offlineOnly ?? this.offlineOnly,
      enableOnlineOcr: enableOnlineOcr ?? this.enableOnlineOcr,
      enableOnlineAi: enableOnlineAi ?? this.enableOnlineAi,
      enableFamilySync: enableFamilySync ?? this.enableFamilySync,
    );
  }
}

class FeatureFlagsRepository {
  static const _offlineOnlyKey = 'flag_offline_only';
  static const _onlineOcrKey = 'flag_online_ocr';
  static const _onlineAiKey = 'flag_online_ai';
  static const _familySyncKey = 'flag_family_sync';

  Future<FeatureFlags> load() async {
    final prefs = await SharedPreferences.getInstance();
    return FeatureFlags(
      offlineOnly: prefs.getBool(_offlineOnlyKey) ?? true,
      enableOnlineOcr: prefs.getBool(_onlineOcrKey) ?? false,
      enableOnlineAi: prefs.getBool(_onlineAiKey) ?? false,
      enableFamilySync: prefs.getBool(_familySyncKey) ?? false,
    );
  }

  Future<void> save(FeatureFlags flags) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_offlineOnlyKey, flags.offlineOnly);
    await prefs.setBool(_onlineOcrKey, flags.enableOnlineOcr);
    await prefs.setBool(_onlineAiKey, flags.enableOnlineAi);
    await prefs.setBool(_familySyncKey, flags.enableFamilySync);
  }
}
