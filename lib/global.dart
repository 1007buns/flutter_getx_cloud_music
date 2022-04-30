import 'package:flutter_getx_cloud_music/style/theme.dart';
import 'package:get/get.dart';

class GlobalService extends GetxService {
  Future<GlobalService> init() async {
    return this;
  }

  static GlobalService get to => Get.find();

  final _isDarkModel = Get.isDarkMode.obs;
  get isDarkModel => _isDarkModel.value;
  set isDarkModel(value) => _isDarkModel.value = value;

  // 切换样式
  void switchThemeModel() {
    _isDarkModel.value = !_isDarkModel.value;
    Get.changeTheme(
      _isDarkModel.value == true ? AppTheme.dark : AppTheme.light,
    );
  }
}
