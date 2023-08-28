import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_connect/data/repository/auth_impl.dart';
import 'package:lets_connect/data/repository/module.dart';
import 'package:lets_connect/domain/model/user.dart';
import 'package:lets_connect/presentation/screens/home/user_provider.dart';
import 'package:lets_connect/presentation/screens/login/login.dart';
import 'package:lets_connect/presentation/screens/login/login_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([FirebaseAuth, FirebaseFirestore, AuthImpl])
void main() {
  testWidgets('Login Screen Test', (tester) async {
    final mockAuthAction = MockAuthImpl();

    when(mockAuthAction.signInWithEmailAndPassword('test@gmail.com', '123456', any))
        .thenAnswer((_) async => UserData(uid: 'uid', fullname: 'fullname', email: 'email', createdate: 'createdate'));

    final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
      ],
    );

    //when(router.push('/home')).thenAnswer(() async => Future.value(null));

    await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authActionsProvider.overrideWithValue(mockAuthAction),
            visibleProvider.overrideWith((ref) => VisibilityNotifier()),
            authUserProvider.overrideWith((ref) => UserNotifier())
          ],
          child: MaterialApp.router(
            routerConfig: _router,
          ),
        )
    );

    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('emailField')), 'test@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordField')), '123456');
    final signInButton = find.byKey(const Key('loginButton'));
    await tester.ensureVisible(signInButton);
    await tester.tap(signInButton);

    verify(mockAuthAction.signInWithEmailAndPassword('test@gmail.com', '123456', any)).called(1);

  });
}