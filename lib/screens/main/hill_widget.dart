import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hill_of_sheep/config/constants.dart';
import 'package:hill_of_sheep/data/hill.dart';
import 'package:hill_of_sheep/screens/main/controllers/hill_controller.dart';

class Hills extends StatelessWidget {
  Hills({super.key, required this.screen});

  final Size screen;

  final HillController controller = Get.put(HillController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        controller.hills.length,
        (index) => OneHill(
          hill: controller.hills[index],
          screen: screen,
        ),
      ),
    );
  }
}

class OneHill extends StatefulWidget {
  const OneHill({
    super.key,
    required this.hill,
    required this.screen,
  });

  final Hill hill;
  final Size screen;

  @override
  State<OneHill> createState() => _OneHillState();
}

class _OneHillState extends State<OneHill> with SingleTickerProviderStateMixin {
  final HillController controller = Get.put(HillController());

  late final Hill hill;
  late final AnimationController _aniController;
  late final Animation<double> _animation;

  @override
  void initState() {
    hill = widget.hill;
    controller.setPoints(screen: widget.screen, hill: hill);

    _aniController = AnimationController(vsync: this, duration: $style.times.ms5000);
    _animation = Tween<double>(begin: 0, end: 1).animate(_aniController);

    _aniController.addListener(() {
      controller.insertPoints(hill: hill, screen: widget.screen); // point 삽입

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
    return ClipPath(
      clipper: HillClipper(hill),
      child: Container(
        color: hill.color,
      ),
    );
  }
}

class HillClipper extends CustomClipper<Path> {
  HillClipper(this.hill, {super.reclip});

  final Hill hill;

  final HillController controller = Get.find<HillController>();

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;

    Point cur = hill.points.first;
    Point pre = cur;

    cur.x += hill.speed;
    Path path = Path()..moveTo(cur.x, cur.y);

    double preCx = cur.x;
    double preCy = cur.y;

    for (int i = 1; i < hill.points.length; i++) {
      hill.points[i].x += hill.speed;
      cur = hill.points[i];

      final double cx = (pre.x + cur.x) / 2;
      final double cy = (pre.y + cur.y) / 2;

      // 곡선 그리기
      path.quadraticBezierTo(pre.x, pre.y, cx, cy);

      // 좌표 세팅
      hill.points[i].x1 = preCx;
      hill.points[i].y1 = preCy;
      hill.points[i].x2 = pre.x;
      hill.points[i].y2 = pre.y;
      hill.points[i].x3 = cx;
      hill.points[i].y3 = cy;

      pre = cur;
      preCx = cx;
      preCy = cy;
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
