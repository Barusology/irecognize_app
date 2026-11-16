import 'package:flutter/material.dart';

import 'auth_screen.dart';

/// Email and password account creation screen.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => AuthScreen(
        isSignUp: true,
        onSwitchMode: () => Navigator.of(context).pushReplacementNamed('/sign-in'),
      );
}
