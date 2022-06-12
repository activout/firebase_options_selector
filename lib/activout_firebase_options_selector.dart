/// When you have multiple Firebase projects for production, test and
/// development, use this library to make it easier to switch between
/// environments without building separate apps!
library activout_firebase_options_selector;

export 'package:activout_firebase_options_selector/src/firebase_options_banner.dart'
    show FirebaseOptionsBanner;
export 'package:activout_firebase_options_selector/src/firebase_options_selector.dart'
    show FirebaseOptionsSelector;
export 'package:activout_firebase_options_selector/src/firebase_options_selector_dialog.dart'
    show showFirebaseOptionsSelectorDialog;
