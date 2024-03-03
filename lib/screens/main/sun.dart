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
    return ClipPath(
      clipper: SunClipper(screen),
      child: Container(
        width: controller.radius,
        height: controller.radius,
        color: $style.colors.sun,
      ),
    );
  }
}

class SunClipper extends CustomClipper<Path> {
  SunClipper(this.screen, {super.reclip});

  final Size screen;

  final SunController controller = Get.find<SunController>();

  @override
  Path getClip(Size size) {
    final double x = screen.width - size.width - 100;
    final double y = screen.height * .1;

    final Point point = controller.points.first;
    Path path = Path()..moveTo(point.x + x, point.y + y);

    for (int i = 1; i < controller.points.length; i++) {
      final Point point = controller.points[i];
      path.lineTo(point.x + x, point.y + y);
      // todo point 계산 이상함
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


// class SunPainter extends CustomPainter {
//   SunPainter(this.screen);
//
//   final Size screen;
//
//   final _paint = Paint()
//     ..color = $style.colors.sun
//     ..style = PaintingStyle.fill;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawOval(
//       Rect.fromLTWH(screen.width - size.width - 100, screen.height * .1, size.width, size.height),
//       _paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }