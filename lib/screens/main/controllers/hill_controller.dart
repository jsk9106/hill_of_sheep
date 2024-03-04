import 'dart:async';
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
      total: 12,
      points: [],
    ),
    Hill(
      color: $style.colors.hotPink,
      total: 10,
      points: [],
    ),
    Hill(
      color: $style.colors.pink,
      total: 8,
      points: [],
    ),
  ];

  void hillInit({required Size screen, required Hill hill, required int index}){
    hill.speed = screen.width / 500 / (hills.length - index); // 언덕 speed 세팅
    setPoints(screen: screen, hill: hill); // 초기 포인트 세팅
    updateHill(screen: screen, hill: hill);
  }

  // 언덕 상태 업데이트
  void updateHill({required Size screen, required Hill hill}){
    Timer.periodic($style.times.ms33, (_) {
      insertPoints(hill: hill, screen: screen); // point 삽입

      update([hill.hashCode]);
    });
  }

  // 초기 points 세팅
  void setPoints({required Size screen, required Hill hill}) {
    final int g = gap(screen.width, hill.total); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -freeNum)

    // points 생성
    for (int i = 0; i < hill.total; i++) {
      final double x = (g * i).toDouble();
      final double y = getY(screen);

      hill.points.add(Point(x, y));
    }
  }

  // 포인트 삽입
  void insertPoints({required Hill hill, required Size screen}) {
    final int g = gap(screen.width, hill.total); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -freeNum)

    if (hill.points.first.x > -g) {
      hill.points.insert(0, Point((g * -2), getY(screen)));
    } else if (hill.points.last.x > screen.width + g * 3) {
      hill.points.removeLast();
    }
  }

  // 랜덤 y
  double getY(Size screen) {
    final double h = screen.height;

    final double min = h / 8;
    final double max = h - min;
    return min + Random().nextDouble() * max;
  }

  // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -freeNum)
  int gap(double w, int total) => (w / (total - freeNum)).ceil();
}
