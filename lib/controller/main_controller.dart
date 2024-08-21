import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../application/configuration/secrets.dart';
import '../application/utils/date_formatter.dart';
import '../model/user.dart';
import '../view/sign_in.dart';
import 'binding/sign_in_binding.dart';

final class MainController extends GetxController {
  MainController({required this.username, required this.email});

  MainController.google({required GoogleSignInUserData this.googleAuthData})
      : username = googleAuthData.displayName ?? '',
        email = googleAuthData.email;

  final dio = Dio();
  final String username;
  final String email;
  final userId = ''.obs;
  final contactText = ''.obs;
  GoogleSignInUserData? googleAuthData;
  Future<void>? initialization;

  late final User user;

  // MARK: - Life Cycle

  @override
  onInit() async {
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    if (id == null) {
      user = await createUser(username: username, email: email);
      await prefs.setString('id', user.id);
    } else {
      user = await fetchUser(id: id);
    }
    userId.value = user.id;
  }

  // MARK: - Private

  // MARK: - API

  Future<User> createUser(
      {required String username, required String email}) async {
    try {
      const url = '${Secrets.baseURL}/user/';
      final data = {
        "username": username,
        "email": email,
        "role": "user",
        "password": 'password',
        "created_at": DateTime.now().iso,
        "updated_at": DateTime.now().iso,
      };
      final response = await dio.post(url, data: data);
      return User.fromMap(response.data as dynamic);
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<User> fetchUser({required String id}) async {
    try {
      const url = '${Secrets.baseURL}/user/info';
      final data = {
        "user_id": id,
      };
      final response = await dio.post(url, data: data);
      return User.fromMap(response.data as dynamic);
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MARK: - Google Sign In

  Future<Map<String, String>> _getAuthHeaders() async {
    final GoogleSignInUserData? user = googleAuthData;
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
