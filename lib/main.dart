import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/navigation_wrapper.dart';
import 'services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const IRecognizeApp(),
    ),
  );
}

class IRecognizeApp extends StatelessWidget {
  const IRecognizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iRecognize',
      theme: IRecognizeTheme.lightTheme,
      useInheritedMediaQuery: true, // Required for DevicePreview
      locale: DevicePreview.locale(context), // Required for DevicePreview
      builder: DevicePreview.appBuilder, // Required for DevicePreview
      home: const _FirebaseGate(),
      routes: {
        '/sign-in': (_) => const SignInScreen(),
        '/sign-up': (_) => const SignUpScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class _FirebaseGate extends StatefulWidget {
  const _FirebaseGate();

  @override
  State<_FirebaseGate> createState() => _FirebaseGateState();
}

class _FirebaseGateState extends State<_FirebaseGate> {
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) _initialization = Firebase.initializeApp();
  }

  void _retry() => setState(() => _initialization = Firebase.initializeApp());

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const _WebFirebaseSetupScreen();
    return FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            return _FirebaseErrorScreen(error: snapshot.error, onRetry: _retry);
          }
          return const _SessionGate();
        },
      );
  }
}

class _WebFirebaseSetupScreen extends StatelessWidget {
  const _WebFirebaseSetupScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.web_asset_off, size: 48),
                  const SizedBox(height: 16),
                  Text('Web Firebase setup required', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  const Text(
                    'This Firebase project has Android and iOS registrations, but no Web app config. To enable sign-in and the archive in Chrome, run this from the project folder and select Web:',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  SelectableText(
                    'flutterfire configure --project=irecognize-5924b',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Then initialize Firebase with DefaultFirebaseOptions.currentPlatform from the generated lib/firebase_options.dart file.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _FirebaseErrorScreen extends StatelessWidget {
  const _FirebaseErrorScreen({required this.error, required this.onRetry});

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 48),
                  const SizedBox(height: 16),
                  Text('Firebase could not start', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  const Text(
                    'The app pages are ready, but Firebase needs a platform config. Android and iOS are configured in this project. For Web or desktop, register that app in Firebase Console and run FlutterFire configure.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  SelectableText('$error', textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  FilledButton(onPressed: onRetry, child: const Text('TRY AGAIN')),
                ],
              ),
            ),
          ),
        ),
      );
}

class _SessionGate extends StatelessWidget {
  const _SessionGate();

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: AuthService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return snapshot.data == null ? const SignInScreen() : const NavigationWrapper();
        },
      );
}
