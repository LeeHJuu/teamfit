import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teamfit/firebase_options.dart';
import 'package:teamfit/src/presentation/views/login/login_page.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // 세로모드 고정
      // await SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]);

      // await Firebase.app().delete();

      await dotenv.load(fileName: ".env");

      await Firebase.initializeApp(
        name: "teamfit",
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      runApp(ProviderScope(child: MyApp()));
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(themeMode: ThemeMode.light, home: LoginPage());
  }
}
