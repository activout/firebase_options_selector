import 'package:activout_firebase_options_selector/firebase_options_selector.dart';
import 'package:flutter/material.dart';

/// Widget that shows a banner with the environment name,
/// unless the app is using the production environment
class FirebaseOptionsBanner extends StatelessWidget {
  /// The widget to show behind the banner.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  const FirebaseOptionsBanner({key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseOptionsSelector.isProduction) {
      return child;
    }
    return Banner(
        textDirection: TextDirection.ltr,
        location: BannerLocation.bottomEnd,
        message: FirebaseOptionsSelector.selectedKey,
        child: child);
  }
}
