import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

/// [MainScreenController] manages the state of the MainScreen widget.
class MainScreenController extends GetxController {
  final _image1 = Image.asset('assets/images/image-1.jpg');
  final _image2 = Image.asset('assets/images/image-2.jpg');
  final _isImageLoading = false.obs;
  ImageInfo? _imageInfo1;
  ImageInfo? _imageInfo2;

  /// Returns the first image.
  Image get image1 => _image1;

  /// Returns the second image.
  Image get image2 => _image2;

  /// Returns the first image information.
  ImageInfo? get imageInfo1 => _imageInfo1;

  /// Returns the second image information.
  ImageInfo? get imageInfo2 => _imageInfo2;

  /// Returns the loading state of the images.
  bool get isImageLoading => _isImageLoading.value;

  @override
  void onInit() {
    super.onInit();

    _initValue();
  }

  Future<void> _initValue() async {
    _isImageLoading.value = true;
    _imageInfo1 = await _getImageInfo(_image1);
    _imageInfo2 = await _getImageInfo(_image2);
    debugPrint('imageInfo1: ${_imageInfo1?.image}');
    _isImageLoading.value = false;
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
