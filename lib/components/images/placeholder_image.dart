import 'package:flutter/material.dart';

import 'package:template/core/constants/images.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(AppImages.avatarPlaceholder),
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
