import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const _currencyKey = 'settings_currency';
  static const _keepLastCategoryKey = 'settings_keep_last_category';

  Future<String> loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencyKey) ?? 'EUR';
  }

  Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyKey, currency);
  }

  Future<bool> loadKeepLastCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keepLastCategoryKey) ?? true;
  }

  Future<void> saveKeepLastCategory(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keepLastCategoryKey, value);
  }
}
