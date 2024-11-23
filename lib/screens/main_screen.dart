import 'package:flutter/material.dart';

/// The home screen widget.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/image-1.jpg'),
          Image.asset('assets/images/image-2.jpg'),
        ],
      ),
    );
  }
}
