import 'package:activout_firebase_options_selector/firebase_options_selector.dart';
import 'package:flutter/material.dart';

class FirebaseOptionsBanner extends StatelessWidget {
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
