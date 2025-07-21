import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teamfit/firebase_options.dart';
import 'package:teamfit/src/config/theme/theme.dart';
import 'package:teamfit/src/presentation/views/home/home_page.dart';
import 'package:teamfit/src/presentation/views/home/pages/home_tap_page/home_tap_page.dart';
import 'package:teamfit/src/presentation/views/login/login_page.dart';
import 'package:teamfit/src/presentation/views/personality_test/personailty_test_page.dart';
import 'package:teamfit/src/presentation/views/signup/service_agreement_page.dart';

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
      themeMode: ThemeMode.light,
      theme: theme,
      home: _startPage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }

  Widget _startPage() {
    // 로그인상태 확인
    final isLogined = false;
    if (isLogined) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
