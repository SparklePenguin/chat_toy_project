import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/common/app_text.dart';
import '../controller/chat_controller.dart';
import 'shared/label.dart';

final class Chat extends GetView<ChatController> {
  const Chat({super.key});

  Widget _buildBody() {
    return const Label(
      text: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '메인',
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
