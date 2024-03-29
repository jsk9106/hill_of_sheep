import 'package:flutter/material.dart';

import 's_text_style.dart';

@immutable
class AppStyle {
  AppStyle({double? sizeUnit}) {
    if (sizeUnit == null) {
      scale = 1;
      return;
    } else {
      scale = sizeUnit;
    }
  }

  late final double scale;

  /// App color
  final AppColors colors = AppColors();

  /// Corner radius
  late final Corners corners = Corners(scale);

  /// Box shadow
  final BoxShadows boxShadows = BoxShadows();

  /// Padding and margin values
  late final Insets insets = Insets(scale);

  /// Text styles
  late final STextStyle text = STextStyle(scale);

  /// Animation Durations
  final Times times = Times();
}

/// App color
@immutable
class AppColors {
  final Color purple = const Color(0xFF6420AA);
  final Color hotPink = const Color(0xFFFF3EA5);
  final Color pink = const Color(0xFFFF7ED4);
  final Color lightPink = const Color(0xFFFFB5DA);
  final Color sun = const Color(0xFFFFb200);
  final Color black = const Color(0xFF333333);
  final Color darkGrey = const Color(0xFF858B8E);
  final Color grey = const Color(0xFFAAAAAA);
  final Color lightGrey = const Color(0xFFF6F8F9);
}

/// Corner radius
@immutable
class Corners {
  Corners(this.scale);

  final double scale;

  late final double $4 = 4 * scale;
  late final double $8 = 8 * scale;
  late final double $10 = 10 * scale;
  late final double $12 = 12 * scale;
  late final double $16 = 16 * scale;
  late final double $24 = 24 * scale;
}

/// Box shadow
@immutable
class BoxShadows {
  final List<BoxShadow> bs1 = const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.2),
      offset: Offset(2, 4),
      blurRadius: 8,
    ),
  ];
}

/// Padding and margin values
@immutable
class Insets {
  Insets(this.scale);

  final double scale;

  late final double $4 = 4 * scale;
  late final double $8 = 8 * scale;
  late final double $10 = 10 * scale;
  late final double $12 = 12 * scale;
  late final double $14 = 14 * scale;
  late final double $16 = 16 * scale;
  late final double $20 = 20 * scale;
  late final double $24 = 24 * scale;
  late final double $30 = 30 * scale;
  late final double $32 = 32 * scale;
  late final double $40 = 40 * scale;
  late final double $48 = 48 * scale;
  late final double $56 = 56 * scale;
  late final double $64 = 64 * scale;
}

/// Animation Durations
@immutable
class Times {
  final Duration ms33 = const Duration(milliseconds: 33); // 30fps
  final Duration ms150 = const Duration(milliseconds: 150);
  final Duration ms300 = const Duration(milliseconds: 300);
  final Duration ms5000 = const Duration(milliseconds: 5000);
}
