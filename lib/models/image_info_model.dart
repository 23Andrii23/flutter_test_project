import 'package:flutter/material.dart';

/// All image information model
class ImageInfoModel {
  /// Image name
  final String name;

  /// Image width
  final int width;

  /// Image height
  final int height;

  /// Image size
  final String size;

  /// Image format
  final String format;

  /// Image longitude
  final String? longitude;

  /// Image latitude
  final String? latitude;

  /// Image color
  final Color? color;

  /// Image information model
  ImageInfoModel({
    required this.name,
    required this.width,
    required this.height,
    required this.size,
    required this.format,
    required this.longitude,
    required this.latitude,
    this.color,
  });
}
