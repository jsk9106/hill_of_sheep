import 'package:flutter/material.dart';
import 'package:hill_of_sheep/config/global_assets.dart';
import 'package:hill_of_sheep/screens/main/hill_widget.dart';
import 'package:sprite/sprite.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Hills(),
          const Sprite(
            imagePath: GlobalAssets.sprite,
            size: Size(250, 250),
            amount: 8,
            flipX: true,
            scale: .5,
            stepTime: 100,
          ),
        ],
      ),
    );
  }
}
