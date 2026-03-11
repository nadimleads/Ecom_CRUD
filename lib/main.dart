import 'package:ecoms/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:ecoms/model/customer_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //Initializes Hive
  Hive.registerAdapter(CustomerAdapter()); //Registers model
  await Hive.openBox<Customer>(
    'customers',
  ); //Opens database //"customers" is the database table.
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
