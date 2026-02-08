import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider observer for debugging and error tracking
final class AppProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    if (kDebugMode) {
      debugPrint(
        '🟢 Provider added: ${context.provider.name ?? context.provider.runtimeType}',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (kDebugMode) {
      debugPrint(
        '🔄 Provider updated: ${context.provider.name ?? context.provider.runtimeType}',
      );
    }
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    if (kDebugMode) {
      debugPrint(
        '🔴 Provider disposed: ${context.provider.name ?? context.provider.runtimeType}',
      );
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
      'Error: $error\n'
      'StackTrace: $stackTrace',
    );

    // In production, you would log this to a crash reporting service
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}
