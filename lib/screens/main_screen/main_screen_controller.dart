import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [MainScreenController] manages the state of the MainScreen widget.
class MainScreenController extends GetxController {
  final _image1 = Image.asset('assets/images/image-1.jpg');
  final _image2 = Image.asset('assets/images/image-2.jpg');

  /// Returns the first image.
  Image get image1 => _image1;

  /// Returns the second image.
  Image get image2 => _image2;
}
