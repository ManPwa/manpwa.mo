import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../todo/index.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'auth/login';
  static const routePath = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton.tonalIcon(
          onPressed: () {
            context.goNamed(TodoListingPage.routeName);
          },
          icon: const Icon(Icons.arrow_right),
          label: const Text('Get Started'),
        ),
      ),
    );
  }
}
