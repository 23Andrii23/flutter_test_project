import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/main_screen/main_screen_controller.dart';
import 'package:get/get.dart';

/// The home screen widget.
class HomeScreen extends GetView<MainScreenController> {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.image1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.image2,
          ),
        ],
      ),
    );
  }
}
