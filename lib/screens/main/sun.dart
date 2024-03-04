import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/config/constants.dart';
import 'package:hill_of_sheep/data/hill.dart';
import 'package:hill_of_sheep/screens/main/controllers/sun_controller.dart';

class Sun extends StatelessWidget {
  Sun({super.key, required this.screen});

  final Size screen;

  final SunController controller = Get.put(SunController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SunController>(
      builder: (_) {
        return ClipPath(
          clipper: SunClipper(screen),
          child: Container(
            color: $style.colors.sun,
          ),
        );
      },
    );
  }
}

class SunClipper extends CustomClipper<Path> {
  SunClipper(this.screen, {super.reclip});

  final Size screen;

  final SunController controller = Get.find<SunController>();

  @override
  Path getClip(Size size) {
    final double x = screen.width * .8;
    final double y = screen.height * .15;

    final Point startPoint = controller.points.first;
    Path path = Path()..moveTo(startPoint.x + x, startPoint.y + y);

    for (int i = 1; i < controller.points.length; i++) {
      final Point point = controller.points[i];
      path.lineTo(point.x + x, point.y + y);
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}