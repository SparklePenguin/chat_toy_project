import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:http/http.dart' as http;

final class SignInController extends GetxController {
  GoogleSignInUserData? currentUser;
  final contactText = ''.obs;
  Future<void>? initialization;

  // MARK: - Life Cycle

  @override
  onInit() {
    super.onInit();
    // signIn();
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

  void _setUser(GoogleSignInUserData? user) {
    currentUser = user;
    if (user != null) {
      handleGetContact(user);
    }
  }

  // MARK: - Google Sign In

  Future<void> signIn() async {
    await _ensureInitialized();
    final GoogleSignInUserData? newUser =
        await GoogleSignInPlatform.instance.signInSilently();
    _setUser(newUser);
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final GoogleSignInUserData? user = currentUser;
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

  Future<void> handleGetContact(GoogleSignInUserData user) async {
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

  Future<void> handleSignOut() async {
    await _ensureInitialized();
    await GoogleSignInPlatform.instance.disconnect();
  }
}
