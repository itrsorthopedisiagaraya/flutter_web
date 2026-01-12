import 'package:flutter/material.dart';

import '../../helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Handle login
      debugPrint('Username: ${usernameController.text}');
      debugPrint('Password: ${passwordController.text}');

      showTopToast(
        context,
        message: 'Login successful!',
        type: SnackBarType.success,
      );

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      Navigator.pushNamed(context, '/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Card(
                        elevation: 0,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLowest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo / Icon
                                Icon(
                                  Icons.lock_outline,
                                  size: 56,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(height: 16),

                                // Title
                                Text(
                                  'Welcome back',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),

                                Text(
                                  'Sign in to continue',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),

                                const SizedBox(height: 24),

                                // Username
                                TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Username is required';
                                    }
                                    if (value.length < 3) {
                                      return 'Minimum 3 characters';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                // Password
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 6) {
                                      return 'Minimum 6 characters';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Login button (Material 3)
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: FilledButton(
                                    onPressed: _login,
                                    child: const Text('Login'),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Sign up
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don’t have an account?"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/regis');
                                      },
                                      child: const Text('Sign Up'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
