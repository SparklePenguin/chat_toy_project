import 'package:get/get.dart';

import '../controller/binding/sign_in_binding.dart';
import '../view/main.dart';
import '../view/sign_in.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.signIn;

  static final routes = [
    GetPage(
      name: _Paths.signIn,
      page: () => const SignIn(),
      binding: SignInBinding(),
      participatesInRootNavigator: true,
      children: [
        GetPage(
          name: _Paths.main,
          page: () => const Main(),
        )
      ],
    ),
  ];
  //   GetPage(
  //     name: '/',
  //     page: () => const RootView(),
  //     bindings: [RootBinding()],
  //     participatesInRootNavigator: true,
  //     preventDuplicates: true,
  //     children: [
  //       GetPage(
  //         middlewares: [
  //           //only enter this route when not authed
  //           EnsureNotAuthedMiddleware(),
  //         ],
  //         name: _Paths.login,
  //         page: () => const LoginView(),
  //         bindings: [LoginBinding()],
  //       ),
  //       GetPage(
  //         preventDuplicates: true,
  //         name: _Paths.home,
  //         page: () => const HomeView(),
  //         bindings: [
  //           HomeBinding(),
  //         ],
  //         title: null,
  //         children: [
  //           GetPage(
  //             name: _Paths.dashboard,
  //             page: () => const DashboardView(),
  //             bindings: [
  //               DashboardBinding(),
  //             ],
  //           ),
  //           GetPage(
  //             middlewares: [
  //               //only enter this route when authed
  //               EnsureAuthMiddleware(),
  //             ],
  //             name: _Paths.profile,
  //             page: () => const ProfileView(),
  //             title: 'Profile',
  //             transition: Transition.size,
  //             bindings: [ProfileBinding()],
  //           ),
  //           GetPage(
  //             name: _Paths.products,
  //             page: () => const ProductsView(),
  //             title: 'Products',
  //             transition: Transition.cupertino,
  //             showCupertinoParallax: true,
  //             participatesInRootNavigator: false,
  //             bindings: [ProductsBinding(), ProductDetailsBinding()],
  //             children: [
  //               GetPage(
  //                 name: _Paths.productDetails,
  //                 transition: Transition.cupertino,
  //                 showCupertinoParallax: true,
  //                 page: () => const ProductDetailsView(),
  //                 bindings: const [],
  //                 middlewares: [
  //                   //only enter this route when authed
  //                   EnsureAuthMiddleware(),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       GetPage(
  //         name: _Paths.settings,
  //         page: () => const SettingsView(),
  //         bindings: [
  //           SettingsBinding(),
  //         ],
  //       ),
  //     ],
  //   ),
  // ];
}
