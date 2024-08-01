import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../application/common/app_color.dart';
import '../application/common/app_text.dart';
import '../controller/sign_in_controller.dart';

final class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  Widget _buildButton({
    required String title,
    required GestureTapCallback onTap,
  }) {
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

  Widget _buildBody() {
    final GoogleSignInUserData? user = controller.currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            title: Text(
              user.displayName ?? 'UnNamed',
              style: const TextStyle(
                fontFamily: AppText.font,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              user.email,
              style: const TextStyle(
                fontFamily: AppText.font,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Obx(() {
            return Text(
              controller.contactText.value,
              style: const TextStyle(
                fontFamily: AppText.font,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            );
          }),
          const Gap(8.0),
          GestureDetector(
            onTap: () {
              if (kDebugMode) print('Did Google Sign Out Button Tapped');
              controller.handleSignOut();
            },
            child: Container(
              child: const Text(
                AppText.googleSignOut,
                style: TextStyle(
                  fontFamily: AppText.font,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Gap(8.0),
          GestureDetector(
            onTap: () {
              controller.handleGetContact(user);
              if (kDebugMode) print('Did Google Get Contact Button Tapped');
            },
            child: Container(
              child: const Text(
                AppText.googleAuthRefresh,
                style: TextStyle(
                  fontFamily: AppText.font,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
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
              _buildButton(
                title: AppText.googleSignin,
                onTap: () {
                  controller.handleGoogleSignIn();
                },
              ),
              const Gap(16),
              _buildButton(
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
