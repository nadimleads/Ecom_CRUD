import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecoms/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    if (_usernameController.text.trim().toLowerCase() == "nadim" &&
        _passwordController.text == "1234") {
      await ref.read(authProvider.notifier).login();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Invalid credentials. Try: nadim / 1234"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [
                      const Color(0xFF1A0033),
                      const Color(0xFF2A1B4A),
                      theme.scaffoldBackgroundColor,
                    ]
                    : [
                      const Color(0xFF6750A4),
                      const Color(0xFF4A148C),
                      const Color(0xFF1A0033),
                    ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Icon(
                    Icons.shopping_bag_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Ecoms",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "Welcome back",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Login Card - Adapts to theme
                  Card(
                    elevation: isDark ? 12 : 20,
                    color: theme.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Sign In",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.textTheme.headlineSmall?.color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),

                            // Username
                            TextFormField(
                              controller: _usernameController,
                              style: TextStyle(
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              decoration: InputDecoration(
                                labelText: "Username",
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: theme.iconTheme.color,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor:
                                    theme.inputDecorationTheme.fillColor ??
                                    (isDark
                                        ? Colors.grey[900]
                                        : Colors.grey[50]),
                              ),
                              validator:
                                  (value) =>
                                      (value == null || value.trim().isEmpty)
                                          ? "Please enter username"
                                          : null,
                            ),

                            const SizedBox(height: 20),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: theme.iconTheme.color,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: theme.iconTheme.color,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () =>
                                            _obscurePassword =
                                                !_obscurePassword,
                                      ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor:
                                    isDark ? Colors.grey[900] : Colors.grey[50],
                              ),
                              validator:
                                  (value) =>
                                      (value == null || value.isEmpty)
                                          ? "Please enter password"
                                          : null,
                            ),

                            const SizedBox(height: 40),

                            // Interactive Login Button
                            GestureDetector(
                              onTap: _isLoading ? null : _login,
                              child: AnimatedScale(
                                scale: _isLoading ? 0.96 : 1.0,
                                duration: const Duration(milliseconds: 150),
                                child: Container(
                                  height: 62,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        theme.colorScheme.primary,
                                        theme.colorScheme.primary.withOpacity(
                                          0.85,
                                        ),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.4),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child:
                                        _isLoading
                                            ? const SizedBox(
                                              height: 28,
                                              width: 28,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3.5,
                                              ),
                                            )
                                            : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "LOGIN",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        theme
                                                            .colorScheme
                                                            .onPrimary,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color:
                                                      theme
                                                          .colorScheme
                                                          .onPrimary,
                                                  size: 26,
                                                ),
                                              ],
                                            ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "Demo: nadim / 1234",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
