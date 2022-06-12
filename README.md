<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Use this library from [Activout AB](https://activout.se) to switch between different Firebase projects in your app.

## Features

When you have multiple Firebase projects for production, test and development, use this library to make it easier to
switch between environments without building separate apps!

## Getting started

1. Create separate Firebase projects for production, test and development (or what you prefer).
2. Generate firebase_options files for each Firebase project with
   the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup).
3. Initialize this library in your main.dart according to the instructions below. It will call `Firebase.initializeApp()` for you!

## Usage

See the `example` subdirectory for a full example.

In your main.dart file, import all your `firebase_options.dart` files generated
by [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup):

```dart
import 'package:example/firebase_options_production.dart' as production;
import 'package:example/firebase_options_test.dart' as test;
import 'package:example/firebase_options_development.dart' as development;
```

Update your `main` method to be `async` call `FirebaseOptionsSelector.initialize()` with `await`:

```dart
Future<void> main() async {
  const productionKey = 'Production';

  await FirebaseOptionsSelector.initialize(productionKey, {
    productionKey: production.DefaultFirebaseOptions.currentPlatform,
    "Test": test.DefaultFirebaseOptions.currentPlatform,
    "Development": development.DefaultFirebaseOptions.currentPlatform,
  });

  runApp(const MyApp());
}
```

When you create your `MaterialApp`, set the `builder` property to add a banner to the app when it is not running with
production options:

```dart
    return MaterialApp(
      builder: FirebaseOptionsSelector.materialAppBuilder,
```

In a secret place, such as triple-tap on your logo, open the Firebase options selector dialog:

```dart
  onPressed: () async {
    await showFirebaseOptionsSelectorDialog(context, "Select environment and restart app");
  },
```

## Additional information

[Activout AB](https://activout.se) is a Swedish Flutter mobile app agency. Maybe we can help your company?
