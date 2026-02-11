import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppTextStyles {
  static const String burmeseFontFamily = 'Myanmar';
  
  // Burmese text styles with platform-specific adjustments
  static TextStyle get burmeseText {
    return TextStyle(
      fontFamily: burmeseFontFamily,
      fontSize: _getBurmeseFontSize(),
      height: _getBurmeseHeight(),
    );
  }
  
  static TextStyle get burmeseTextMedium {
    return burmeseText.copyWith(
      fontSize: _getBurmeseFontSize() + 2,
      fontWeight: FontWeight.w500,
    );
  }
  
  static TextStyle get burmeseTextLarge {
    return burmeseText.copyWith(
      fontSize: _getBurmeseFontSize() + 4,
      fontWeight: FontWeight.w600,
    );
  }
  
  // Platform-specific font sizes
  static double _getBurmeseFontSize() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 14.0; // iOS needs slightly smaller font
    } else {
      return 15.0; // Android standard size
    }
  }
  
  // Platform-specific line heights
  static double _getBurmeseHeight() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 1.3; // iOS needs tighter line height
    } else {
      return 1.4; // Android standard line height
    }
  }
}
