import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootLayout extends StatelessWidget {
  const RootLayout(
      {super.key,
      required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 860;
        if(isTablet) {
          return buildTablet(context);
        } else {
          return buildMobile(context);
        }
      },
    );
  }

  Widget buildTablet(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Expanded(child: Scaffold(body: child)),
        ],
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
