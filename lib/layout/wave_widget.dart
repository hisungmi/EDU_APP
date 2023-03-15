import 'dart:math';
import 'package:flutter/cupertino.dart';

class WaveWidget extends StatefulWidget {
  const WaveWidget({super.key});

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4500));
    _animation = Tween<double>(begin: 0, end: 2*pi).animate(_animationController);

    _animationController.addListener(() {
      setState(() {

      });
    });
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(_animation.value),
      child: Container(
      color: const Color(0xff0099FF),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  WaveClipper(this.animationValue);
  final double animationValue;

  @override
  Path getClip(Size size) {
    var p = Path();
    var points = <Offset>[];

    for(var x = 0; x<size.width; x++) {
      points.add(Offset(x.toDouble(), WaveClipper.getYWithX(x, animationValue)));
    }

    p.moveTo(0, WaveClipper.getYWithX(0, animationValue));
    p.addPolygon(points, false);
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);

    return p;
  }

  static const double waveHeight = 50;
  static double getYWithX(int x, double animationValue) {
    var y = ((sin(animationValue + x * 0.01) + 1) / 2) * 150; // 0 - 1

    return y;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
