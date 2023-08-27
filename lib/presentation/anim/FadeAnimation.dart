import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({super.key, required this.delay, required this.child});
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
    ..tween('opacity', Tween(begin: 0.0, end: 1.0), duration: const Duration(milliseconds: 500))
    .thenTween('translateY', Tween(begin: -30.0, end: 0.0), duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    return CustomAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get('opacity'),
        child: Transform.translate(
            offset: Offset(0, animation.get("translateY"),
        ),
          child: child,
      ),
    ),
    );
  }
}


