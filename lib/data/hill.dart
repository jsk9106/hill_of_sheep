import 'package:flutter/material.dart';

class Hill {
  Hill({
    required this.color,
    this.speed = 0,
    required this.total,
    required this.points,
  });

  final Color color;
  double speed;
  final int total;
  List<Point> points;
}

class Point {
  Point(
    this.x,
    this.y, [
    this.x1 = 0,
    this.y1 = 0,
    this.x2 = 0,
    this.y2 = 0,
    this.x3 = 0,
    this.y3 = 0,
  ]);

  double x;
  double y;
  double x1;
  double y1;
  double x2;
  double y2;
  double x3;
  double y3;
}
