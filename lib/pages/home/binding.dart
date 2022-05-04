import 'package:flutter_getx_cloud_music/global.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/index.dart';
import 'package:flutter_getx_cloud_music/widgets/controller/play_song_controller.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DiscoveryController>(() => DiscoveryController());
    Get.lazyPut<PlaySongController>(() => PlaySongController());
    Get.lazyPut<GlobalService>(() => GlobalService());
  }
}
