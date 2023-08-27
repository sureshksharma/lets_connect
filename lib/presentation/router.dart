import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_connect/presentation/screens/call/CallPage.dart';
import 'package:lets_connect/presentation/screens/home/home.dart';
import 'package:lets_connect/presentation/screens/login/login.dart';
import 'package:lets_connect/presentation/screens/register/register.dart';
import 'package:lets_connect/presentation/screens/root.dart';

GoRouter buildRouter() {
  return GoRouter(
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
            destinations: const [
              Destination(
                  label: 'Register',
                  selectedIcon: Icons.note,
                  unselectedIcon: Icons.note_outlined
              ),
              Destination(
                  label: 'Login',
                  selectedIcon: Icons.store,
                  unselectedIcon: Icons.store_outlined
              ),
              Destination(
                  label: 'Home',
                  selectedIcon: Icons.store,
                  unselectedIcon: Icons.store_outlined
              ),
              Destination(
                  label: 'Call',
                  selectedIcon: Icons.store,
                  unselectedIcon: Icons.store_outlined
              ),
            ],
            navigationIndex: index,
            onDestination: (index) {
              switch(index) {
                case 0:
                  context.go('/register');
                  break;
                case 1:
                  context.go('/');
                  break;
                case 2:
                  context.go('/home');
                  break;
              }
            },
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
              GoRoute(
                path: 'call/:callId/user/:userId/name/:userName',
                builder: (_, state) {
                  final callId = state.pathParameters['callId'];
                  final userId = state.pathParameters['userId'];
                  final userName = state.pathParameters['userName'];
                  return CallPage(
                    callID: callId!,
                    userID: userId!,
                    userName: userName!,
                  );
                },
              ),
            ],
          ),
        ],
      )
    ]
  );
}
