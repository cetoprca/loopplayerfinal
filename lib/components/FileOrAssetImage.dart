import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class FileOrAssetImage extends StatelessWidget {
  final String filePath;        // ruta del archivo local
  final String fallbackAsset;   // asset a usar si no existe el archivo
  final double? width;
  final double? height;
  final BoxFit? fit;

  const FileOrAssetImage({
    required this.filePath,
    required this.fallbackAsset,
    this.width,
    this.height,
    this.fit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    final file = File(filePath);

    if (file.existsSync()) {
      // Si el archivo existe, lo mostramos
      return Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      // Si no existe, usamos el asset
      return Image.asset(
        fallbackAsset,
        width: width,
        height: height,
        fit: fit,
        color: colors.accent,
      );
    }
  }
}