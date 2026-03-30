import 'package:ecoms/screens/login_screen.dart';
import 'package:ecoms/screens/home_screen.dart';
import 'package:ecoms/screens/create_customer_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoms/providers/auth_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (!isLoggedIn) return '/login';
      if (isLoggedIn && state.fullPath == '/login') return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/create-customer',
        builder: (context, state) => const CreateCustomerScreen(),
      ),
    ],
  );
});
