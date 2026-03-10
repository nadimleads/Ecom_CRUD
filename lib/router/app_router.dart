import 'package:go_router/go_router.dart';
import 'package:ecoms/screens/create_customer_screen.dart';
import 'package:ecoms/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    //main to home page
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),

    //create customer
    GoRoute(
      path: '/create-customer',
      builder: (context, state) => CreateCustomerScreen(),
    ),
  ],
);
