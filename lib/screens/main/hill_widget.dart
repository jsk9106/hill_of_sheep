import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/data/hill.dart';
import 'package:hill_of_sheep/screens/main/controllers/hill_controller.dart';
import 'dart:math';

import '../../config/constants.dart';

class Hills extends StatelessWidget {
  Hills({super.key});

  final HillController controller = Get.put(HillController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size screen = constraints.biggest;

        return GetBuilder<HillController>(
          initState: (state) => controller.init(screen),
          builder: (_) {
            return Stack(
              children: List.generate(
                controller.hills.length,
                (index) => OneHill(
                  hill: controller.hills[index],
                  screen: screen,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class OneHill extends StatelessWidget {
  const OneHill({
    super.key,
    required this.hill,
    required this.screen,
  });

  final Hill hill;
  final Size screen;

  @override
  Widget build(BuildContext context) {
    RxDouble x = .0.obs;

    WidgetsBinding.instance.addPostFrameCallback((_) => x.value += hill.speed);

    return Obx(
      () => AnimatedPositioned(
        duration: $style.times.ms300,
        left: x.value,
        onEnd: () => x.value += hill.speed,
        child: ClipPath(
          clipper: HillClipper(
            points: hill.points,
            speed: hill.speed,
          ),
          child: Container(
            width: Get.width,
            height: Get.height,
            color: hill.color,
          ),
        ),
      ),
    );
  }
}

class HillClipper extends CustomClipper<Path> {
  HillClipper({super.reclip, required this.points, required this.speed});

  final List<Offset> points;
  final double speed;

  final HillController controller = Get.find<HillController>();

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    // final int gap = (w / (total - 2)).ceil(); // 포인트 사이의 갭 (화면보다 크게 그리기 위해 total에 -2)
    //
    // // 랜덤 y
    // double getY() {
    //   final double min = h / 8;
    //   final double max = h - min;
    //   return min + Random().nextDouble() * max;
    // }
    //
    // for (int i = 0; i < total; i++) {
    //   final double x = (gap * i).toDouble();
    //   final double y = getY();
    //
    //   points.add(Offset(x, y));
    // }

    Offset cur = points.first;
    Offset pre = cur;

    Path path = Path()..moveTo(cur.dx, cur.dy);

    for (int i = 1; i < points.length; i++) {
      cur = points[i];

      final double cx = (pre.dx + cur.dx) / 2;
      final double cy = (pre.dy + cur.dy) / 2;

      path.quadraticBezierTo(pre.dx, pre.dy, cx, cy);

      pre = cur;
    }

    path
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
