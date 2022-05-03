import 'package:get/get.dart';

import 'controller.dart';

class MineBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(() => MineController());
  }
}
