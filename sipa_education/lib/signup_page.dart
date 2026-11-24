import 'package:flutter/material.dart';

import 'auth_page_shell.dart';
import 'logic.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;

    startDemoSession(
      name: _nameController.text,
      email: _emailController.text,
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      title: 'Create your account',
      subtitle: 'Join SIPA and start building your learning journey.',
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const ValueKey('signup-name'),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your name.'
                  : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              key: const ValueKey('signup-email'),
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
            const SizedBox(height: 14),
            TextFormField(
              key: const ValueKey('signup-password'),
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
              textInputAction: TextInputAction.next,
              validator: validatePassword,
            ),
            const SizedBox(height: 14),
            TextFormField(
              key: const ValueKey('signup-confirm-password'),
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm password',
                prefixIcon: Icon(Icons.lock_reset_rounded),
              ),
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              validator: (value) => value != _passwordController.text
                  ? 'Passwords do not match.'
                  : null,
              onFieldSubmitted: (_) => _signUp(),
            ),
            const SizedBox(height: 22),
            FilledButton(
              key: const ValueKey('signup-submit'),
              onPressed: _signUp,
              child: const Text('Create account'),
            ),
            const SizedBox(height: 14),
            Text(
              'Demo access only. Account details are not saved.',
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
          const Text('Already have an account?'),
          TextButton(
            key: const ValueKey('open-login'),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/login'),
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
