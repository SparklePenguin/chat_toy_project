import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../view/main.dart';
import 'binding/main_binding.dart';

final class SignInController extends GetxController {
  Future<void>? initialization;

  // MARK: - Life Cycle

  // @override
  // onInit() {
  //   super.onInit();
  // }

  // MARK: - Google Sign In

  Future<void> _ensureInitialized() {
    return initialization ??= GoogleSignInPlatform.instance.initWithParams(
      const SignInInitParameters(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ),
    )..catchError((dynamic _) {
        initialization = null;
      });
  }

  Future<void> _googleSignIn() async {
    await _ensureInitialized();
    final GoogleSignInUserData? newUser =
        await GoogleSignInPlatform.instance.signInSilently();
    _setUser(newUser);
  }

  Future<void> handleGoogleSignIn() async {
    try {
      await _ensureInitialized();
      _setUser(await GoogleSignInPlatform.instance.signIn());
    } catch (error) {
      final bool canceled =
          error is PlatformException && error.code == 'sign_in_canceled';
      if (!canceled) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
  }

  // MARK: - Route

  void _setUser(GoogleSignInUserData? user) {
    if (user != null) {
      Get.off(
        () => const Main(),
        binding: MainBinding.google(googleAuthData: user),
      );
    }
  }
}
