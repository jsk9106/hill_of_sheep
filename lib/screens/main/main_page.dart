import 'package:flutter/material.dart';
import 'package:hill_of_sheep/config/global_assets.dart';
import 'package:hill_of_sheep/screens/main/hill_widget.dart';
import 'package:hill_of_sheep/screens/main/sheep.dart';
import 'package:sprite/sprite.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size screen = constraints.biggest;

          return Stack(
            children: [
              Hills(screen: screen),
              ...List.generate(3, (index) => Sheep(screen: screen)),
            ],
          );
        }
      ),
    );
  }
}
