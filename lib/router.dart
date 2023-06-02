import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/manga/index.dart' as feat_home;
import 'features/auth/index.dart' as feat_auth;

final GoRouter rootRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => Container(),
      redirect: (context, state) =>
          state.fullPath == '/' ? '/manga' : null,
      routes: <RouteBase>[
        // feat_auth.setupRoutes(),
        feat_home.setupRoutes(),
      ],
    ),
  ],
);
