import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
        messagingSenderId: 'messagingSenderId',
        apiKey: 'apiKey',
        projectId: 'projectId',
        appId: 'appId');
  }
}
