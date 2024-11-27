import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final impProvider = ChangeNotifierProvider((ref) => ImgProvidet());

class ImgProvidet extends ChangeNotifier {
  Uint8List? _imgPath;
  bool _isUploadImg = false;
  String? _img;

  void uploadimgPath({required Uint8List? imgpath, required String img}) {
    _imgPath = imgpath;
    _img = img;
    _isUploadImg = true;
    notifyListeners();
  }

  bool get isUploadImg => _isUploadImg;
  Uint8List? get imgPath => _imgPath;
  String? get img => _img;
}
