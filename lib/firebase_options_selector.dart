library activout_firebase_options_selector;

import 'package:activout_firebase_options_selector/firebase_options_banner.dart';
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions, defaultFirebaseAppName;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseOptionsSelector {
  static const _storageKey = 'environment';
  static String productionKey = '';
  static Map<String, FirebaseOptions> availableOptions = {};
  static String selectedKey = '';

  static bool get isProduction => selectedKey == productionKey;

  static Future<void> initialize(String productionKey,
      Map<String, FirebaseOptions> availableOptions) async {
    FirebaseOptionsSelector.productionKey = productionKey;
    FirebaseOptionsSelector.availableOptions = availableOptions;

    WidgetsFlutterBinding.ensureInitialized();

    selectedKey = await getCurrentSelection();

    await Firebase.initializeApp(
      options: availableOptions[selectedKey],
      name: defaultFirebaseAppName,
    );
  }

  static Future<String> getCurrentSelection() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_storageKey);
    return availableOptions.keys
        .firstWhere((element) => element == value, orElse: () => productionKey);
  }

  static Widget materialAppBuilder(BuildContext context, Widget? child) =>
      FirebaseOptionsBanner(child: child!);

  static Future<void> select(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_storageKey, newValue);
  }
}
