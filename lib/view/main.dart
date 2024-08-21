import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../application/common/app_text.dart';
import '../controller/main_controller.dart';
import 'shared/button.dart';
import 'shared/label.dart';

final class Main extends GetView<MainController> {
  const Main({super.key});

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(text: '이름: ${controller.username}'),
            const Gap(4.0),
            Label(text: '이메일: ${controller.email}'),
            const Gap(4.0),
            Obx(
              () => Label(text: 'id: ${controller.userId}'),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Label(text: 'API Response: ${controller.contactText}'),
            ),
            const Gap(4.0),
            Button(
              title: AppText.googleAuthRefresh,
              onTap: () {
                controller.handleGetContact();
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(text: '로그아웃'),
            const Gap(4.0),
            Button(
              title: AppText.googleSignOut,
              onTap: () {
                controller.handleSignOut();
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
          AppText.chatMain,
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
