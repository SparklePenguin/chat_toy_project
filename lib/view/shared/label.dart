import 'package:flutter/material.dart';

import '../../application/common/app_text.dart';

final class Label extends StatelessWidget {
  const Label({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppText.font,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
