import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider observer for debugging and error tracking
final class AppProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    // Only log in debug mode and limit verbosity
    if (kDebugMode && context.provider.name != null) {
      debugPrint('🟢 ${context.provider.name}');
    }
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    // Reduce logging frequency for better performance
    if (kDebugMode &&
        context.provider.name != null &&
        previousValue != newValue) {
      debugPrint('🔄 ${context.provider.name}');
    }
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    // Minimal logging for better performance
    if (kDebugMode && context.provider.name != null) {
      debugPrint('🔴 ${context.provider.name}');
    }
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    debugPrint(
      '❌ Provider failed: ${context.provider.name ?? context.provider.runtimeType}\n'
      'Error: $error',
    );

    // In production, you would log this to a crash reporting service
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}
