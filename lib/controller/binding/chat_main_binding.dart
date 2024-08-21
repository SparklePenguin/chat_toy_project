import 'package:chat_toy_project/controller/main_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../../model/user.dart';

final class ChatMainBinding implements Bindings {
  ChatMainBinding({required GoogleSignInUserData googleAuthData})
      : _username = googleAuthData.displayName ?? "NoNamed..",
        _email = googleAuthData.email,
        _googleAuthData = googleAuthData;

  final String _email;
  final String _username;
  final GoogleSignInUserData _googleAuthData;

  @override
  void dependencies() {
    Get.lazyPut(
      () => MainController(
        username: _username,
        email: _email,
        googleUser: _googleAuthData,
      ),
    );
  }
}
