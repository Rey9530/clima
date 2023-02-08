import 'package:flutter/material.dart';

class BackgroundComponent extends StatelessWidget {
  const BackgroundComponent({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFF41648A), Color(0XFF013E7D)],
              stops: [0.0, 1.0],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: child,
        ),
      ],
    );
  }
}
