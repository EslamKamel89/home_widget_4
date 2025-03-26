import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key,
      required this.rowCount,
      required this.height,
      required this.space,
      required this.width});
  final int rowCount;
  final double height;
  final double width;
  final double space;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rowCount, (index) {
        return Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(vertical: space),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
        ).animate(onPlay: (c) => c.repeat()).fade(
            delay: (100 * index).ms, duration: 500.ms, begin: 0.5, end: 1);
      }),
    );
  }
}
