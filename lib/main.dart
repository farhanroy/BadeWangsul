import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'src/app.dart';
import 'src/services/repository/authentication_repository/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initCrashlytics();
  runApp(App(authenticationRepository: AuthenticationRepository(),));
}

// Define an async function to initialize FlutterFire
Future<void> _initCrashlytics() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  // Pass all uncaught errors to Crashlytics.
  Function originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    // Forward to original handler.
    originalOnError(errorDetails);
  };
}
