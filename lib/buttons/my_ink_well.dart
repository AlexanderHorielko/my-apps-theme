import 'package:flutter/material.dart';

class MyInkWell extends StatelessWidget {
  final Function? onTap;
  final Widget child;
  final double borderRadius;

  const MyInkWell({
    Key? key,
    required this.onTap,
    required this.child,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap as void Function()?,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
