import 'package:activout_firebase_options_selector/src/firebase_options_banner.dart';
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions, defaultFirebaseAppName;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main class for persisting a Firebase environment in [SharedPreferences]
class FirebaseOptionsSelector {
  static const _storageKey = 'environment';
  static String _productionKey = '';
  static Map<String, FirebaseOptions> _availableOptions = {};
  static String _selectedKey = '';

  /// Check if we are using the production environment
  static bool get isProduction => selectedKey == _productionKey;

  /// Map environment names to [FirebaseOptions]
  static Map<String, FirebaseOptions> get availableOptions => _availableOptions;

  /// Name of current environment
  static String get selectedKey => _selectedKey;

  /// Read environment selection from [SharedPreferences] and run
  /// [Firebase.initializeApp] with the selected [FirebaseOptions]
  static Future<void> initialize(String productionKey,
      Map<String, FirebaseOptions> availableOptions) async {
    _productionKey = productionKey;
    _availableOptions = availableOptions;

    WidgetsFlutterBinding.ensureInitialized();

    _selectedKey = await getCurrentSelection();

    await Firebase.initializeApp(
      options: availableOptions[selectedKey],
      name:
          selectedKey == _productionKey ? defaultFirebaseAppName : selectedKey,
    );
  }

  /// Get the current selection from [SharedPreferences]
  static Future<String> getCurrentSelection() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_storageKey);
    return availableOptions.keys.firstWhere((element) => element == value,
        orElse: () => _productionKey);
  }

  /// Shortcut to use [FirebaseOptionsBanner] as the builder for [MaterialApp]
  static Widget materialAppBuilder(BuildContext context, Widget? child) =>
      FirebaseOptionsBanner(child: child!);

  /// Select a different environment for the next time the app starts
  static Future<void> select(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_storageKey, newValue);
  }
}
