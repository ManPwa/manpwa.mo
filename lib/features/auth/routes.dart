import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/index.dart';

GoRoute setupRoutes() {
  return GoRoute(
    path: 'auth',
    builder: (context, state) => Container(),
    redirect: (_, __) => '/auth/login',
    routes: [
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routePath,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
  );
}
