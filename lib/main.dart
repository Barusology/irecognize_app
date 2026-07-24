import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'core/theme.dart';
import 'screens/navigation_wrapper.dart';

void main() {
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
      home: const NavigationWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
