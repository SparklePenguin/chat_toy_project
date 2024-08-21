import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../main_controller.dart';

final class MainBinding implements Bindings {
  MainBinding.google({required GoogleSignInUserData this.googleAuthData});

  GoogleSignInUserData? googleAuthData;

  @override
  void dependencies() {
    Get.lazyPut(
      () {
        if (googleAuthData != null) {
          return MainController.google(googleAuthData: googleAuthData!);
        } else {
          throw UnimplementedError();
          // return MainController();
        }
      },
    );
  }
}
