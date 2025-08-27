import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teamfit/firebase_options.dart';
import 'package:teamfit/src/config/theme/theme.dart';
import 'package:teamfit/src/views/home/home_page.dart';
import 'package:teamfit/src/views/auth/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await EasyLocalization.ensureInitialized();

      await dotenv.load(fileName: ".env");

      await Firebase.initializeApp(
        // name: "teamfit",
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      runApp(
        EasyLocalization(
          supportedLocales: [Locale('ko', 'KR')],
          path: 'assets/translations',
          // fallbackLocale: Locale('ko', 'KR'),
          useFallbackTranslations: true,
          child: ProviderScope(child: MyApp()),
        ),
      );
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
    return MaterialApp(
      title: 'TeamFit',
      themeMode: ThemeMode.light,
      theme: theme,
      home: _buildHomePage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }

  Widget _buildHomePage() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
