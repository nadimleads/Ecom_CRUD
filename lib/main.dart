import 'package:ecoms/router/app_router.dart';
import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CustomerAdapter());

  await Hive.openBox<Customer>('customers');

  runApp(const ProviderScope(child: TheApp()));
}

class TheApp extends ConsumerWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //for theme
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ecom CRUD Learning',

      routerConfig: appRouter,

      /// Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),

      /// Dark Theme
      darkTheme: ThemeData(brightness: Brightness.dark),

      /// Theme controller
      themeMode: themeMode,
    );
  }
}
