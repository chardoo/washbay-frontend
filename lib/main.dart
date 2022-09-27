import 'package:bayfrontend/bindings/login_binding.dart';
import 'package:bayfrontend/bindings/register_binding.dart';
import 'package:bayfrontend/bindings/user_controller_binding.dart';
import 'package:bayfrontend/contollers/user_controller.dart';
import 'package:bayfrontend/middlewares/global_middleware.dart';
import 'package:bayfrontend/screens/Agent/Home.dart';
import 'package:bayfrontend/screens/admin/AllUserScreen.dart';
import 'package:bayfrontend/screens/admin/login.dart';
import 'package:bayfrontend/screens/Sales.dart';
import 'package:bayfrontend/screens/finalReport.dart';
import 'package:bayfrontend/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bindings/serviceType_binding.dart';
import 'package:bayfrontend/bindings/home_binding.dart';
import 'package:bayfrontend/screens/login.dart';
import 'package:bayfrontend/screens/Dashboard.dart';
import 'package:bayfrontend/screens/allServiceType.dart';
import 'package:bayfrontend/components/serviceType/DetailsServiceType.dart';
import 'contollers/serviceType_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'screens/SignUp.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '/middlewares/global_middleware.dart';
// import 'screens/cartScreen.dart';
// import 'screens/splash.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.lazyPut(() => ServiceTypesController());
  Get.lazyPut(
    () => UserController(),
  );
  RegisterBinding().dependencies();
  LoginBinding().dependencies();

  runApp(GetMaterialApp(
    home: const SplashScreen(),
    getPages: [
      GetPage(
        name: '/splash',
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
        bindings: [LoginBinding()],
      ),
      GetPage(
        name: '/dashboard',
        page: () => DashBoard(),
        bindings: [HomeControllerBinding(), UserControllerBinding()],
        middlewares: [AdminMiddleware()],
      ),
      GetPage(
        name: '/allService',
        page: () => ServiceType(),
        binding: ServiceTypeControllerBinding(),
        middlewares: [AdminMiddleware()],
      ),
      GetPage(
        name: '/sales',
        page: () => Sales(),
        binding: ServiceTypeControllerBinding(),
        middlewares: [AdminMiddleware()],
      ),
      GetPage(
        name: '/admin/login',
        page: () => AgentLoginScreen(),
        bindings: [LoginBinding()],
      ),
      GetPage(
        name: '/allUsers',
        page: () => AllUserScreen(),
        bindings: [HomeControllerBinding(), UserControllerBinding()],
        middlewares: [AdminMiddleware()],
      ),
      GetPage(
        name: '/SalesPage',
        page: () => AgentDashBoard(),
        bindings: [HomeControllerBinding(), UserControllerBinding()],
        middlewares: [GlobalMiddleware()],
      ),
    ],
  ));
}
