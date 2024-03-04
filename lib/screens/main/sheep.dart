import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/screens/main/controllers/sheep_controller.dart';
import 'package:sprite/sprite.dart';

import '../../config/global_assets.dart';

class Sheep extends StatelessWidget {
  Sheep({super.key, required this.screen, required this.index});

  final Size screen;
  final int index;

  late final SheepController controller = Get.put(SheepController(), tag: index.toString());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SheepController>(
      initState: (state) => controller.init(screen),
      tag: index.toString(),
      builder: (context) {
        return Positioned(
          left: controller.x - controller.sheepWidth / 2,
          top: controller.y - controller.sheepHeight / 2 - 30,
          child: Transform.rotate(
            angle: controller.rotation,
            child: const Sprite(
              imagePath: GlobalAssets.sheep,
              size: Size(360, 300),
              amount: 8,
              scale: .3,
              stepTime: 100,
            ),
          ),
        );
      },
    );
  }
}
