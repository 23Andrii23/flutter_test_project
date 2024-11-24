import 'package:flutter/material.dart';
import 'package:flutter_test_project/app.dart';
import 'package:flutter_test_project/data/init_controllers.dart';

Future<void> main() async {
  await initControllers();
  runApp(const App());
}
