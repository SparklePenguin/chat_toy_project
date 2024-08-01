import 'package:chat_toy_project/controller/sign_in_controller.dart';
import 'package:get/get.dart';

final class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
