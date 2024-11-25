import 'dart:async';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test_project/models/image_info_model.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart' as path;

/// [MainScreenController] manages the state of the MainScreen widget.
class MainScreenController extends GetxController {
  final _image1 = Image.asset('assets/images/image-1.jpg');
  final _image2 = Image.asset('assets/images/image-2.jpg');
  final _isImageLoading = false.obs;
  ImageInfoModel? _imageInfoModelOne;
  ImageInfoModel? _imageInfoModelTwo;

  /// Returns the first image.
  Image get image1 => _image1;

  /// Returns the second image.
  Image get image2 => _image2;

  /// Returns the loading state of the images.
  bool get isImageLoading => _isImageLoading.value;

  /// Returns the information model of the first image.
  ImageInfoModel? get imageInfoOne => _imageInfoModelOne;

  /// Returns the information model of the second image.
  ImageInfoModel? get imageInfoTwo => _imageInfoModelTwo;

  @override
  void onInit() {
    super.onInit();

    _initValue();
  }

  Future<void> _initValue() async {
    _isImageLoading.value = true;
    final imageInfo1 = await _getImageInfo(_image1);
    final imageInfo2 = await _getImageInfo(_image2);
    final colorOne = await _getDominantColor(_image1.image);
    final colorTwo = await _getDominantColor(_image2.image);
    final latitudeOne = await _getExifInfo(
      coordinateType: CoordinateType.latitude,
      image: 'assets/images/image-1.jpg',
    );
    final longitudeOne = await _getExifInfo(
      coordinateType: CoordinateType.longitude,
      image: 'assets/images/image-1.jpg',
    );
    final latitudeTwo = await _getExifInfo(
      coordinateType: CoordinateType.latitude,
      image: 'assets/images/image-2.jpg',
    );
    final longitudeTwo = await _getExifInfo(
      coordinateType: CoordinateType.longitude,
      image: 'assets/images/image-2.jpg',
    );
    _imageInfoModelOne = ImageInfoModel(
      name: imageInfo1.debugLabel ?? '',
      width: imageInfo1.image.width,
      height: imageInfo1.image.height,
      size: imageSize(imageInfo1),
      format: imageInfo1.debugLabel?.split('.').last ?? '',
      latitude: latitudeOne,
      longitude: longitudeOne,
      color: colorOne,
    );

    _imageInfoModelTwo = ImageInfoModel(
      name: imageInfo2.debugLabel ?? '',
      width: imageInfo2.image.width,
      height: imageInfo2.image.height,
      size: imageSize(imageInfo2),
      format: imageInfo2.debugLabel?.split('.').last ?? '',
      latitude: latitudeTwo,
      longitude: longitudeTwo,
      color: colorTwo,
    );

    _isImageLoading.value = false;
  }

  Future<Color> _getDominantColor(ImageProvider imageProvider) async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    return paletteGenerator.dominantColor?.color ?? Colors.transparent;
  }

  Future<String> _getExifInfo({
    required CoordinateType coordinateType,
    required String image,
  }) async {
    final data = await rootBundle.load(image);
    final bytes = data.buffer.asUint8List();
    final exifData = await readExifFromBytes(bytes);
    if (coordinateType == CoordinateType.latitude) {
      final latitude = exifData['GPS GPSLatitude']?.values.toList() ?? [];

      if (latitude.isEmpty) return '';

      final coordinates = _formatedCoordinate(latitude);
      final latitudeRef = exifData['GPS GPSLatitudeRef'];
      return '$coordinates $latitudeRef';
    } else {
      final longitude = exifData['GPS GPSLongitude']?.values.toList() ?? [];
      if (longitude.isEmpty) return '';

      final coordinates = _formatedCoordinate(longitude);
      final longitudeRef = exifData['GPS GPSLongitudeRef'];
      return '$coordinates $longitudeRef';
    }
  }

  String _formatedCoordinate(List<dynamic> exifValue) {
    final degrees = exifValue[0];
    final minutes = exifValue[1];
    final seconds = exifValue[2];
    return '$degrees° $minutes\' $seconds"';
  }

  /// Returns the size of the image.
  String imageSize(ImageInfo? imageInfo) {
    if (imageInfo != null) {
      final size = imageInfo.sizeBytes;
      return '${_bytesToMB(size).toStringAsFixed(2)} MB';
    }
    return '';
  }

  /// Returns the file name of the image.
  String getFileName(String imageLabel) {
    return path.basename(imageLabel);
  }

  Future<ImageInfo> _getImageInfo(Image img) async {
    final completer = Completer<ImageInfo>();
    final stream = img.image.resolve(ImageConfiguration.empty);

    stream.addListener(
      ImageStreamListener(
        (ImageInfo info, _) => completer.complete(info),
      ),
    );

    return completer.future;
  }

  double _bytesToMB(int bytes) {
    return bytes / (1024 * 1024);
  }
}

/// Enum for the coordinate type.
enum CoordinateType {
  /// Latitude.
  latitude,

  /// Longitude.
  longitude,
}
