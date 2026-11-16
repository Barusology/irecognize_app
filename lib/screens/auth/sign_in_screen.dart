import 'package:flutter/material.dart';

import 'auth_screen.dart';

/// Email and password sign-in screen.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => AuthScreen(
        isSignUp: false,
        onSwitchMode: () => Navigator.of(context).pushReplacementNamed('/sign-up'),
      );
}
