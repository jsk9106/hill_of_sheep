import 'package:flutter/material.dart';
import 'package:hill_of_sheep/screens/main/hill_widget.dart';
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
              Sun(screen: screen),
              Hills(screen: screen),
              ...List.generate(5, (index) => Sheep(screen: screen, index: index)),
            ],
          );
        }
      ),
    );
  }
}
