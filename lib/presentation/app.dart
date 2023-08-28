import 'package:flutter/material.dart';
import 'package:lets_connect/presentation/router.dart';
import 'package:lets_connect/presentation/theme.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class LetsConnect extends StatefulWidget {
  const LetsConnect({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<LetsConnect> createState() => _LetsConnectState();
}

class _LetsConnectState extends State<LetsConnect> {
  late final router = buildRouter(widget.navigatorKey);
  final theme = AppTheme();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lets Connect',
      theme: theme.toThemeData(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}
