import 'package:flutter/material.dart';
import 'package:flutter_remoter/flutter_remoter.dart';

import 'router.dart';

class RootApplication extends StatefulWidget {
  const RootApplication({super.key});

  @override
  State<RootApplication> createState() => _RootApplicationState();
}

class _RootApplicationState extends State<RootApplication> {
  @override
  Widget build(BuildContext context) {
    return RemoterProvider(
      client: RemoterClient(
        options: RemoterOptions(
          staleTime: 0,
          cacheTime: 5 * 60 * 1000,
          maxDelay: 3 * 60 * 1000,
          maxRetries: 1,
          retryOnMount: true,
        ),
      ),
      child: MaterialApp.router(
        routerConfig: rootRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
