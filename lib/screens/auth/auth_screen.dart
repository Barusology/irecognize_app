import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isSignUp, required this.onSwitchMode});

  final bool isSignUp;
  final VoidCallback onSwitchMode;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = AuthService();
  bool _busy = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _busy = true; _error = null; });
    try {
      if (widget.isSignUp) {
        await _auth.signUp(_email.text, _password.text);
      } else {
        await _auth.signIn(_email.text, _password.text);
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _error = switch (e.code) {
        'email-already-in-use' => 'An account already uses this email. Try signing in.',
        'weak-password' => 'Choose a password with at least 6 characters.',
        'invalid-email' => 'Enter a valid email address.',
        'user-not-found' || 'wrong-password' || 'invalid-credential' => 'Email or password is incorrect.',
        _ => e.message ?? 'Authentication failed. Please try again.',
      });
    } catch (_) {
      setState(() => _error = 'Could not connect. Check your connection and Firebase setup.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFF090A0C),
      body: Stack(fit: StackFit.expand, children: [
        const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF253532), Color(0xFF101513), Color(0xFF090A0C)]))),
        SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(28), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 440), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.center_focus_strong_rounded, size: 34, color: Color(0xFFC9A66B)),
          const SizedBox(height: 56),
          Text('A closer look\nat the world.', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, fontSize: 46, height: 1.0)),
          const SizedBox(height: 16),
          Text('Keep every discovery in one personal field archive.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70, height: 1.5)),
          const SizedBox(height: 40),
          Form(key: _formKey, child: Column(children: [
            TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, autofillHints: const [AutofillHints.email], decoration: _decoration('Email address', Icons.alternate_email), validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email.'),
            const SizedBox(height: 14),
            TextFormField(controller: _password, obscureText: _obscurePassword, autofillHints: [widget.isSignUp ? AutofillHints.newPassword : AutofillHints.password], decoration: _decoration('Password', Icons.lock_outline).copyWith(suffixIcon: IconButton(onPressed: () => setState(() => _obscurePassword = !_obscurePassword), icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white54))), validator: (v) => v != null && v.length >= 6 ? null : 'Use at least 6 characters.'),
            if (_error != null) ...[const SizedBox(height: 14), Align(alignment: Alignment.centerLeft, child: Text(_error!, style: const TextStyle(color: Color(0xFFFF9A8D))))],
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 56, child: FilledButton(onPressed: _busy ? null : _submit, style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC9A66B), foregroundColor: const Color(0xFF17140F)), child: _busy ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.isSignUp ? 'CREATE ACCOUNT' : 'SIGN IN', style: const TextStyle(letterSpacing: 1.4, fontWeight: FontWeight.w700)))),
          ])),
          const SizedBox(height: 18),
          Center(child: TextButton(onPressed: widget.onSwitchMode, child: Text(widget.isSignUp ? 'Already have an account? Sign in' : 'New here? Create your archive', style: TextStyle(color: colors.onSurface.withValues(alpha: 0.78))))),
        ]))))),
      ]),
    );
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(labelText: label, prefixIcon: Icon(icon), filled: true, fillColor: Colors.white.withValues(alpha: 0.07), labelStyle: const TextStyle(color: Colors.white70), prefixIconColor: const Color(0xFFC9A66B), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.14))), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.14))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFC9A66B))));
}
