import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/data/hill.dart';

import '../../../config/constants.dart';

class HillController extends GetxController {
  final int freeNum = 2; // 화면보다 크게 그리기 위해 total에 -할 수

  //  양 크기
  final double sheepWidth = 120;
  final double sheepHeight = 100;

  List<Hill> hills = [
    Hill(
      color: $style.colors.purple,
      speed: .2,
      total: 12,
      points: [],
    ),
    Hill(
      color: $style.colors.hotPink,
      speed: .5,
      total: 10,
      points: [],
    ),
    Hill(
      color: $style.colors.pink,
      speed: 1,
      total: 8,
      points: [],
    ),
  ];


  // 랜덤 y
  double getY(Size screen) {
    final double h = screen.height;

    final double min = h / 8;
    final double max = h - min;
    return min + Random().nextDouble() * max;
  }

  // 초기 points 세팅
  void setPoints({required Size screen, required Hill hill}) {
    final int g = gap(screen.width, hill.total); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -2)

    // points 생성
    for (int i = 0; i < hill.total; i++) {
      final double x = (g * i).toDouble();
      final double y = getY(screen);

      hill.points.add(Point(x, y));
    }
  }

  // 포인트 삽입
  void insertPoints({required Hill hill, required Size screen}) {
    final int g = gap(screen.width, hill.total); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -2)

    if (hill.points.first.x > -g) {
      hill.points.insert(0, Point((g * -2), getY(screen)));
    } else if (hill.points.last.x > screen.width + g * 3) {
      hill.points.removeLast();
    }
  }

  int gap(double w, int total) => (w / (total - freeNum)).ceil(); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -2)
}
