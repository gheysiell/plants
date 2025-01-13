import 'package:flutter/material.dart';
import 'package:plants/shared/palette.dart';

class NotFoundWidget extends StatelessWidget {
  final String title;
  final double height;
  final double paddingBottom;

  const NotFoundWidget({
    super.key,
    required this.title,
    required this.height,
    required this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/icon.png',
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              color: Palette.grayMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: paddingBottom,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
