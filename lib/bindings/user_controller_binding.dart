import 'package:get/get.dart';
import 'package:bayfrontend/contollers/user_controller.dart';

class UserControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
