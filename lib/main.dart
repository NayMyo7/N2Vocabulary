import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'src/app.dart';
import 'src/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await MobileAds.instance.initialize();
  } catch (e) {
    debugPrint('AdMob initialization failed: $e');
  }

  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const MyApp(),
    ),
  );
}
