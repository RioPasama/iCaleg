import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainScreen(),
      binding: MainControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.FORGET_PASSWORD,
      page: () => const ForgetPasswordScreen(),
      binding: ForgetPasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTRY,
      page: () => const RegistryScreen(),
      binding: RegistryControllerBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTRY_VERIFICATION,
      page: () => const RegistryVerificationScreen(),
      binding: RegistryVerificationControllerBinding(),
    ),
  ];
}
