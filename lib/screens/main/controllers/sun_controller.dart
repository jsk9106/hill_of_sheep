import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hill_of_sheep/data/hill.dart';

class SunController extends GetxController {
  static const int total = 60;
  final double radius = 200;

  final List<Point> points = [];
  final List<Point> originPoints = [];

  @override
  void onInit() {
    const double gap = 1 / total;

    // 포인트 세팅
    for (int i = 0; i < total; i++) {
      final Point point = getCirclePoint(radius: radius, t: gap * i);
      originPoints.add(point);
      points.add(point);
    }

    // 포인트 업데이트
    Timer.periodic(
      Duration(microseconds: (1 / total * 1000).toInt()),
      (_) {
        updatePoints();
        update();
      },
    );

    super.onInit();
  }

  List<Point> updatePoints() {
    for (int i = 1; i < total; i++) {
      final Point p = originPoints[i];

      points[i].x = p.x + Random().nextInt(5);
      points[i].y = p.y + Random().nextInt(5);
    }

    return points;
  }

  // 원 좌표 가져오기
  Point getCirclePoint({required double radius, required double t}) {
    final double theta = pi * 2 * t;

    return Point(cos(theta) * radius, sin(theta) * radius);
  }
}
