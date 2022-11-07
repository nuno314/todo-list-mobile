import '../../../di/di.dart';
import '../../theme/theme_data.dart';
import 'preferences_helper/preferences_helper.dart';

class LocalDataManager extends AppPreferenceData {
  late final _prefs = injector.get<PreferencesHelper>();
  late final LocalDataManager _localDataManager = injector.get();

  static Future<LocalDataManager> init() async {
    return Future.value(LocalDataManager());
  }

  @override
  String? getLocalization() {
    return _localDataManager.getLocalization();
  }

  @override
  SupportedTheme getTheme() {
    return _localDataManager.getTheme();
  }

  @override
  Future<bool?> saveLocalization(String? locale) {
    return _localDataManager.saveLocalization(locale);
  }

  @override
  Future<bool?> setTheme(String? data) {
    return _localDataManager.setTheme(data);
  }

  @override
  Future<bool?> clearData() async {
    return _prefs.clearData();
  }
}
