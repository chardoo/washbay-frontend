import 'package:get/get.dart';
import 'package:bayfrontend/contollers/serviceType_controller.dart';

class ServiceTypeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ServiceTypesController());
  }
}
