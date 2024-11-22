import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/main_screen.dart';

/// The main application widget that configures the app theme and initial route.
class App extends StatelessWidget {
  /// Creates an [App] widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
