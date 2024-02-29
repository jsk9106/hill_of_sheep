import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/data/hill.dart';

import '../../../config/constants.dart';

class HillController extends GetxController {
  List<Hill> hills = [
    Hill(
      color: $style.colors.purple,
      speed: 5,
      total: 12,
      points: [],
    ),
    Hill(
      color: $style.colors.hotPink,
      speed: 10,
      total: 10,
      points: [],
    ),
    Hill(
      color: $style.colors.pink,
      speed: 15,
      total: 8,
      points: [],
    ),
  ];

  void init(Size screen) {
    setPoints(screen); // 초기 points 세팅
  }

  // 초기 points 세팅
  void setPoints(Size screen) {
    double w = screen.width;
    double h = screen.height;

    // 랜덤 y
    double getY() {
      final double min = h / 8;
      final double max = h - min;
      return min + Random().nextDouble() * max;
    }

    // points 세팅
    for (int i = 0; i < hills.length; i++) {
      final Hill hill = hills[i];

      final int gap = (w / (hill.total - 2)).ceil(); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -2)

      for (int i = 0; i < hill.total; i++) {
        final double x = (gap * i).toDouble();
        final double y = getY();

        hill.points.add(Offset(x, y));
      }
    }
  }

  void setX(Hill hill) {

  }
}
