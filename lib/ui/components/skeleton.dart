import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const Skeleton({
    required this.width,
    required this.height,
    required this.radius,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final double width;
  final double height;
  final double radius;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      baseColor: const Color(0xffe2e3e4),
      highlightColor: const Color(0xfff5f6f6),
      period: const Duration(seconds: 3),
    );
  }
}
