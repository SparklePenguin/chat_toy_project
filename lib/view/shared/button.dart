import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';

final class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) print('Did Google $title Button Tapped');
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.border,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(
            fontFamily: AppText.font,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
