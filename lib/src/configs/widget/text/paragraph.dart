import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/app_styles.dart';

class Paragraph extends StatelessWidget {
  const Paragraph({
    super.key,
    required this.content,
    this.style,
    this.fontWeight,
    this.color,
    this.overflow,
    this.textAlign,
    this.maxLines,
    this.size,
  });
  final String? content;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign,
      content ?? '',
      style: style ??
          STYLE_LARGE_BIG.copyWith(
            fontWeight: fontWeight,
            color: color ?? Colors.white,
            fontSize: size,
          ),
      overflow: overflow,
    );
  }
}
