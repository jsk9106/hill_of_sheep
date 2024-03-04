import 'package:flutter/material.dart';
import 'package:hill_of_sheep/screens/main/hills.dart';
import 'package:hill_of_sheep/screens/main/sheep.dart';

import 'sun.dart';

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
              Sun(screen: screen), // 태양
              Hills(screen: screen), // 언덕
              ...List.generate(5, (index) => Sheep(screen: screen, index: index)), // 양
            ],
          );
        }
      ),
    );
  }
}
