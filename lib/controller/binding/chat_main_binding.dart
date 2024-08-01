import 'package:chat_toy_project/controller/chat_main_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../../model/user.dart';

final class ChatMainBinding implements Bindings {
  ChatMainBinding({required GoogleSignInUserData googleAuthData})
      : _user = User(
          name: googleAuthData.displayName ?? "NoNamed..",
          email: googleAuthData.email,
        ),
        _googleAuthData = googleAuthData;

  final User _user;
  final GoogleSignInUserData _googleAuthData;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ChatMainController(
        user: _user,
        googleUser: _googleAuthData,
      ),
    );
  }
}
