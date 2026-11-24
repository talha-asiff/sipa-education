import 'package:flutter/material.dart';

import 'auth_page_shell.dart';
import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;

    startDemoSession(email: _emailController.text);
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      title: 'Welcome back',
      subtitle: 'Sign in to continue learning with SIPA.',
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const ValueKey('login-email'),
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const ValueKey('login-password'),
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              validator: validatePassword,
              onFieldSubmitted: (_) => _signIn(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              key: const ValueKey('login-submit'),
              onPressed: _signIn,
              child: const Text('Sign in'),
            ),
            const SizedBox(height: 16),
            Text(
              'Demo access only. Credentials are not sent or saved.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      footer: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('New to SIPA?'),
          TextButton(
            key: const ValueKey('open-signup'),
            onPressed: () => Navigator.of(context).pushNamed('/signup'),
            child: const Text('Create an account'),
          ),
        ],
      ),
    );
  }
}
