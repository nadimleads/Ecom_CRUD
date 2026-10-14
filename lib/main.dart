import 'package:ecoms/model/blood_group_model.dart';
import 'package:ecoms/model/customer_model.dart';
import 'package:ecoms/model/gender_model.dart';
import 'package:ecoms/providers/app_router_provider.dart';
import 'package:ecoms/providers/theme_provider.dart';
import 'package:ecoms/utils/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:country_picker/country_picker.dart';

import 'utils/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  //adding Hive model Adapters
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(GenderModelAdapter());
  Hive.registerAdapter(BloodGroupModelAdapter());

  await Hive.openBox<Customer>('customers');

  runApp(const ProviderScope(child: TheApp()));
}

class TheApp extends ConsumerWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router, // use this router
      debugShowCheckedModeBanner: false,
      title: 'Ecom CRUD Learning Project',
      //This 'theme' and 'darktheme' is for controlling the coloring
      theme: lightTheme,
      darkTheme: darkTheme,
      //this part is for tracking the checking
      themeMode: themeMode,
    );
  }
}
