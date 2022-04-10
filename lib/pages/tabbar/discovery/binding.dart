import 'package:get/get.dart';
import 'index.dart';

// 绑定控制器
class DiscoveryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscoveryController>(() => DiscoveryController());
  }
}
