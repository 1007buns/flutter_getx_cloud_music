import 'dart:convert';

import 'package:flutter_getx_cloud_music/utils/dio_util/dio_method.dart';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_response.dart';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_util.dart';
import 'package:get/get.dart';

class DiscoveryController extends GetxController {
  var isLoding = false.obs;
  List swiper = [].obs;

  @override
  void onInit() {
    super.onInit();
    getBanners();
    // isLodingData();
  }

  void isLodingData() async {
    if (swiper.isNotEmpty) {
      isLoding.value == true;
    }
  }

// 获取/banner数据
  Future<void> getBanners() async {
    DioResponse res = await DioUtil().request(
      '/banner',
      method: DioMethod.get,
      params: {"type": 1},
    );

    Map<String, dynamic> data = jsonDecode(res.data);
    // print("是否是Map类型" + data is Map);
    List banners = data['banners'];

    if (res.code == 0) {
      banners.forEach((items) => swiper.add(items));
      // swiper.add(data['banners']);
      isLoding.value = true;
    } else {
      getBanners();
    }
  }
}
