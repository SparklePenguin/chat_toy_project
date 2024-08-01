import 'package:chat_toy_project/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/binding/sign_in_binding.dart';

final class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/signIn',
      getPages: [
        GetPage(
          name: '/signIn',
          page: () => const SignIn(),
          binding: SignInBinding(),
        ),
      ],
    );
  }
}
