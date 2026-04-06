import 'package:ecoms/providers/auth_provider.dart';
import 'package:ecoms/router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider);
  return createRouter(isLoggedIn);
});
