import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../application/common/app_text.dart';
import '../controller/sign_in_controller.dart';
import 'shared/button.dart';

final class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Chat Toy Project 에 \n오신 것을 환영해요!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppText.font,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          children: [
            Button(
              title: '애플로 로그인하기',
              onTap: () {},
            ),
            const Gap(16),
            Button(
              title: AppText.googleSignin,
              onTap: () {
                controller.handleGoogleSignIn();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.signin,
          style: TextStyle(
            fontFamily: AppText.font,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: _buildBody(),
        ),
      ),
    );
  }
}
