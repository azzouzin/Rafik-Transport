import 'package:get/get.dart';
import 'package:rafik/Controller/authcontroller.dart';
import 'package:rafik/Controller/ridescontroller.dart';
import 'package:rafik/Controller/usercontoller.dart';

import '../locationsController.dart';

class Homebindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LocationsController());
    Get.put(RidesController());
    Get.put(Authcontroller());
    Get.put(UserContoller(), permanent: true);
  }
}
