import 'dart:convert';

import 'package:chat_toy_project/controller/binding/sign_in_binding.dart';
import 'package:chat_toy_project/model/user.dart';
import 'package:chat_toy_project/view/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:http/http.dart' as http;

final class ChatMainController extends GetxController {
  ChatMainController({required this.user, this.googleUser});

  final User user;
  final GoogleSignInUserData? googleUser;
  final contactText = ''.obs;
  Future<void>? initialization;

  // MARK: - Life Cycle

  // MARK: - Google Sign In

  Future<Map<String, String>> _getAuthHeaders() async {
    final GoogleSignInUserData? user = googleUser;
    if (user == null) {
      throw StateError('No user signed in');
    }

    final GoogleSignInTokenData response =
        await GoogleSignInPlatform.instance.getTokens(
      email: user.email,
      shouldRecoverAuth: true,
    );

    return <String, String>{
      'Authorization': 'Bearer ${response.accessToken}',
      // TODO(kevmoo): Use the correct value once it's available.
      // See https://github.com/flutter/flutter/issues/80905
      'X-Goog-AuthUser': '0',
    };
  }

  Future<void> handleGetContact() async {
    contactText.value = 'Loading contact info...';
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await _getAuthHeaders(),
    );
    if (response.statusCode != 200) {
      contactText.value = 'People API gave a ${response.statusCode} '
          'response. Check logs for details.';
      if (kDebugMode) {
        print('People API ${response.statusCode} response: ${response.body}');
      }

      return;
    }

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final int contactCount =
        (data['connections'] as List<dynamic>?)?.length ?? 0;
    contactText.value = '$contactCount contacts found';
  }

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

  Future<void> handleSignOut() async {
    await _ensureInitialized();
    await GoogleSignInPlatform.instance.disconnect();
    Get.off(
      const SignIn(),
      binding: SignInBinding(),
    );
  }
}
