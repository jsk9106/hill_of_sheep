import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/config/constants.dart';
import 'package:hill_of_sheep/screens/main/controllers/hill_controller.dart';

import '../../../data/hill.dart';

class SheepController extends GetxController {
  final HillController hillController = Get.find<HillController>();
  late final Hill hill = hillController.hills.last;

  late double x; // 양 x 좌표
  double y = 0; // 양 y 좌표
  double rotation = 0; // 양 기울기

  final double speed = .5 + Random().nextDouble();

  //  양 크기
  final double sheepWidth = 108;
  final double sheepHeight = 90;

  void init(Size screen) {
    x = screen.width + sheepWidth;

    updateSheep(screen); // 양 상태 업데이트
  }

  // 양 상태 업데이트
  void updateSheep(Size screen) {
    Timer.periodic($style.times.ms33, (_) {
      x -= speed; // 양 y좌표 세팅
      x = resetSheepPosition(screen: screen, x: x) ?? x; // 양 포지션 리셋

      (Point, double) quad = getSheepY(x: x);
      y = quad.$1.y; // 양 y좌표 세팅
      rotation = quad.$2; // 양 기울기 세팅

      update();
    });
  }

  // 양 위치 리셋
  double? resetSheepPosition({required Size screen, required double x}) {
    if (x <= -sheepWidth / 2) {
      return x = screen.width + sheepWidth;
    }

    return null;
  }

  // 양 y좌표
  (Point, double) getSheepY({required double x}) {
    for (int i = 1; i < hill.points.length; i++) {
      if (x >= hill.points[i].x1 && x <= hill.points[i].x3) {
        return getSheepY2(x, hill.points[i]);
      }
    }

    return (Point(0, 0), .0);
  }

  // 양 세부 y좌표
  (Point, double) getSheepY2(double x, Point dot) {
    const total = 2000;
    (Point, double) quad = getPointOnQuad(dot.x1, dot.y1, dot.x2, dot.y2, dot.x3, dot.y3, 0);
    Point pt = quad.$1;
    double preX = pt.x;

    for (int i = 1; i < total; i++) {
      final double t = i / total;
      (Point, double) quad = getPointOnQuad(dot.x1, dot.y1, dot.x2, dot.y2, dot.x3, dot.y3, t);
      pt = quad.$1;

      if (x >= preX && x <= pt.x) {
        return quad;
      }

      preX = pt.x;
    }

    return quad;
  }

  // 2차 배지어 곡선 수식 (곡선)
  double getQuadValue(double p0, double p1, double p2, double t) {
    return (1 - t) * (1 - t) * p0 + 2 * (1 - t) * t * p1 + t * t * p2;
  }

  // 곡선 좌표 Point
  (Point, double) getPointOnQuad(double x1, double y1, double x2, double y2, double x3, double y3, double t) {
    // 각도 구하기
    final tx = quadTangent(x1, x2, x3, t);
    final ty = quadTangent(y1, y2, y3, t);
    final double rotation = atan2(ty, tx);

    return (
      Point(
        getQuadValue(x1, x2, x3, t),
        getQuadValue(y1, y2, y3, t),
      ),
      rotation,
    );
  }

  // 2차 배지어 곡선 수식 (선형)
  double quadTangent(double a, double b, double c, double t) {
    return 2 * (1 - t) * (b - a) + 2 * (c - b) * t;
  }
}
