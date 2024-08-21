import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

final class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PenguinChat",
      // initialBinding: ,
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
    );
  }
}
