import 'package:get/get.dart';
import 'package:bayfrontend/contollers/home_controller.dart';

class HomeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
