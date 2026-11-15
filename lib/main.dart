import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/navigation_wrapper.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const _SessionGate(),
      debugShowCheckedModeBanner: false,
    );
  }
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
          return snapshot.data == null ? const AuthScreen() : const NavigationWrapper();
        },
      );
}
