import 'package:ecoms/screens/create_customer_screen.dart';
import 'package:ecoms/screens/home_sceen/home_screen.dart';
import 'package:ecoms/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/login';

      // Not logged in → Force go to Login screen
      if (!isLoggedIn) {
        return isGoingToLogin ? null : '/login';
      }

      // Logged in → Don't allow access to Login screen
      if (isLoggedIn && isGoingToLogin) {
        return '/';
      }

      // Allow access to all other routes
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
}
