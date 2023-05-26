import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/todo/index.dart' as feat_todo;
import 'features/auth/index.dart' as feat_auth;

final GoRouter rootRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => Container(),
      redirect: (context, state) =>
          state.fullPath == '/' ? '/auth/login' : null,
      routes: <RouteBase>[
        feat_auth.setupRoutes(),
        feat_todo.setupRoutes(),
      ],
    ),
  ],
);
