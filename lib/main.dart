import 'package:ecoms/router/app_router.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'screens/home_screen.dart';

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ecom CRUD Learning',
      routerConfig: appRouter,
    );
  }
}
