import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'src/app.dart';
import 'src/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start app immediately, initialize services in background
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const MyApp(),
    ),
  );

  // Initialize AdMob in background without blocking app startup
  MobileAds.instance
      .initialize()
      .timeout(
        const Duration(seconds: 5),
      )
      .catchError((e) {
    debugPrint('AdMob initialization failed: $e');
    return e; // Return error to satisfy return type
  });
}
