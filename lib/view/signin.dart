import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/common/app_text.dart';
import '../controller/signin_controller.dart';

final class Signin extends GetView<SigninController> {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.signin,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: const Text(''),
    );
  }
}
