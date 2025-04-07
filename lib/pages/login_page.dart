import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/custom_widgets/custom_button.dart';
import 'package:the_diet_and_welness_app/utils/utils.dart'; // For showing messages

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Animation state
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger fade-in after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if the widget is still in the tree
        setState(() => _opacity = 1.0);
      }
    });
  }

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Basic validation placeholder
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual login logic later (Firebase)
      showInfoMessage(context, 'Login Placeholder: Success!');
      // Navigate to home on success (placeholder)
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a SafeArea to avoid overlapping with system UI
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.health_and_safety,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'Login to continue',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 40),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(
                    milliseconds: 800,
                  ), // Adjust duration
                  curve: Curves.easeIn, // Adjust curve
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            // Add suffix icon for show/hide password later if needed
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            // Add more password validation if needed later
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        // Using ElevatedButton directly to use the global theme
                        ElevatedButton(
                          onPressed: _handleLogin,
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            // Navigate to Sign Up page
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text('Don\'t have an account? Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
