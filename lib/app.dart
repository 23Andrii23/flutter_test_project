import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/main_screen/main_screen.dart';
import 'package:get/get.dart';

/// The main application widget that configures the app theme and initial route.
class App extends StatelessWidget {
  /// Creates an [App] widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
