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
  final _imageOnePath = 'assets/images/image-1.jpg';
  final _imageTwoPath = 'assets/images/image-2.jpg';
  final _imageOne = Image.asset('assets/images/image-1.jpg');
  final _imageTwo = Image.asset('assets/images/image-2.jpg');
  final _isImageLoading = false.obs;
  ImageInfoModel? _imageInfoModelOne;
  ImageInfoModel? _imageInfoModelTwo;

  /// Returns the first image.
  Image get image1 => _imageOne;

  /// Returns the second image.
  Image get image2 => _imageTwo;

  /// Returns the loading state of the images.
  bool get isImageLoading => _isImageLoading.value;

  /// Sets the loading state of the images.
  set isImageLoading(bool value) => _isImageLoading.value = value;

  /// Returns the information model of the first image.
  ImageInfoModel? get imageInfoOne => _imageInfoModelOne;

  /// Returns the information model of the second image.
  ImageInfoModel? get imageInfoTwo => _imageInfoModelTwo;

  ///Image One Path
  String get imageOnePath => _imageOnePath;

  ///Image Two Path
  String get imageTwoPath => _imageTwoPath;

  @override
  void onInit() {
    super.onInit();

    _initValue();
  }

  Future<void> _initValue() async {
    _isImageLoading.value = true;
    final imageInfo1 = await _getImageInfo(_imageOne);
    final imageInfo2 = await _getImageInfo(_imageTwo);
    final colorOne = await _getDominantColor(_imageOne.image);
    final colorTwo = await _getDominantColor(_imageTwo.image);

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
      size: _imageSize(imageInfo1),
      format: imageInfo1.debugLabel?.split('.').last ?? '',
      latitude: latitudeOne,
      longitude: longitudeOne,
      color: colorOne,
    );

    _imageInfoModelTwo = ImageInfoModel(
      name: imageInfo2.debugLabel ?? '',
      width: imageInfo2.image.width,
      height: imageInfo2.image.height,
      size: _imageSize(imageInfo2),
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

      if (latitude.isEmpty) return '-';

      final coordinates = _formatedCoordinate(latitude);
      final latitudeRef = exifData['GPS GPSLatitudeRef'];
      return '$coordinates $latitudeRef';
    } else {
      final longitude = exifData['GPS GPSLongitude']?.values.toList() ?? [];
      if (longitude.isEmpty) return '-';

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
  String _imageSize(ImageInfo? imageInfo) {
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

  /// Returns if the first number is bigger than the second.
  bool? isBiggerThenAnother(int? first, int? second) {
    if (first != null && second != null) {
      return first > second;
    }
    return null;
  }

  /// Returns if the first image size is bigger than the second one.
  bool isBiggerSize(String? first, String? second) {
    if (first != null && second != null) {
      final firstNumber = double.parse(first.replaceAll(" MB", ""));
      final secondNumber = double.parse(second.replaceAll(" MB", ""));
      return firstNumber > secondNumber;
    }
    return false;
  }
}

/// Enum for the coordinate type.
enum CoordinateType {
  /// Latitude.
  latitude,

  /// Longitude.
  longitude,
}
