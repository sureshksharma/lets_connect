import 'package:flutter/material.dart';
import 'package:lets_connect/presentation/router.dart';
import 'package:lets_connect/presentation/theme.dart';

class LetsConnect extends StatefulWidget {
  const LetsConnect({super.key});

  @override
  State<LetsConnect> createState() => _LetsConnectState();
}

class _LetsConnectState extends State<LetsConnect> {
  late final router = buildRouter();
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
    );
  }
}
