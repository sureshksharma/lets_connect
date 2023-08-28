import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_connect/presentation/screens/home/home.dart';
import 'package:lets_connect/presentation/screens/login/login.dart';
import 'package:lets_connect/presentation/screens/register/register.dart';
import 'package:lets_connect/presentation/screens/root.dart';

GoRouter buildRouter(GlobalKey<NavigatorState> navigatorKey) {
  return GoRouter(
    navigatorKey: navigatorKey,
      initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          int index = 1;
          final location = state.uri.toString();
          if(location.startsWith('/register')){
            index = 0;
          } else if(location.startsWith('/home')){
            index = 2;
          }

          return RootLayout(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (_, state) => LoginScreen(),
            routes: [
              GoRoute(
                path: 'register',
                builder: (_, state) => RegisterScreen(),
              ),
              GoRoute(
                path: 'home',
                builder: (_, state) => HomeScreen(),
              ),
            ],
          ),
        ],
      )
    ]
  );
}
