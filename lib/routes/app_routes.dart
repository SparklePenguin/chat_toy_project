part of 'app_pages.dart';

abstract class Routes {
  static const signIn = _Paths.signIn;

  static const main = _Paths.main;

  static const chatList = _Paths.chatList;
  static const chat = _Paths.chatList + _Paths.chat;

  static const home = _Paths.home;

  static const profile = _Paths.home + _Paths.profile;
  static const settings = _Paths.settings;

  static const products = _Paths.home + _Paths.products;

  static const login = _Paths.login;
  static const dashboard = _Paths.home + _Paths.dashboard;

  Routes._();

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static String PRODUCT_DETAILS(String productId) => '$products/$productId';
}

abstract class _Paths {
  static const main = "/main";
  static const signIn = "/signIn";
  static const chatList = '/chatList';
  static const chat = '/:productId';

  static const home = '/home';
  static const products = '/products';
  static const profile = '/profile';
  static const settings = '/settings';
  static const productDetails = '/:productId';
  static const login = '/login';
  static const dashboard = '/dashboard';
}
