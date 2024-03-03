import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/screens/main/controllers/hill_controller.dart';
import 'package:hill_of_sheep/screens/main/controllers/sheep_controller.dart';
import 'package:sprite/sprite.dart';

import '../../config/constants.dart';
import '../../config/global_assets.dart';
import '../../data/hill.dart';

class Sheep extends StatefulWidget {
  const Sheep({super.key, required this.screen});

  final Size screen;

  @override
  State<Sheep> createState() => _SheepState();
}

class _SheepState extends State<Sheep> with SingleTickerProviderStateMixin {
  final SheepController controller = Get.put(SheepController());
  final HillController hillController = Get.find<HillController>();

  late double x;
  double y = 0;
  double rotation = 0; // 양 기울기

  late final AnimationController _aniController;
  late final Animation<double> _animation;
  late final Hill hill;

  final double speed = .1 + Random().nextDouble();

  @override
  void initState() {
    x = widget.screen.width + controller.sheepWidth;
    hill = hillController.hills.last;

    _aniController = AnimationController(vsync: this, duration: $style.times.ms5000);
    _animation = Tween<double>(begin: 0, end: 1).animate(_aniController);

    _aniController.addListener(() {
      x -= speed;
      x = controller.resetSheepPosition(screen: widget.screen, x: x) ?? x; // 양 포지션 리셋

      (Point, double) quad = controller.getSheepY(hill: hill, x: x);
      y = quad.$1.y; // 양 y좌표 세팅
      rotation = quad.$2; // 양 기울기 세팅

      if (_aniController.isCompleted) _aniController.repeat();

      setState(() {});
    });

    _aniController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x - controller.sheepWidth / 2,
      top: y - controller.sheepHeight / 2 - 30,
      child: Transform.rotate(
        angle: rotation,
        child: const Sprite(
          imagePath: GlobalAssets.sheep,
          size: Size(360, 300),
          amount: 8,
          scale: .3,
          stepTime: 100,
        ),
      ),
    );
  }
}
