import 'package:flutter/material.dart';

class Hill {
  Hill({
    required this.color,
    required this.speed,
    required this.total,
    required this.points,
  });

  final Color color;
  final double speed;
  final int total;
  List<Offset> points;
}
