import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class Discovery extends GetView<DiscoveryController> {
  const Discovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('发现')),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [buildSwiperBanner()],
      ));

  /// 轮播图
  SliverToBoxAdapter buildSwiperBanner() {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 2.5,
          child: Obx(() => controller.isLoding.value == true
              ? Swiper.children(
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white.withOpacity(0.38),
                      activeColor: Colors.red,
                      size: 7.0,
                      activeSize: 10.0,
                      space: 2.0,
                    ),
                  ),
                  autoplay: true,
                  physics: const BouncingScrollPhysics(),
                  children: controller.swiper
                      .map((element) => Container(
                            margin: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(element['pic'],
                                  fit: BoxFit.cover),
                            ),
                          ))
                      .toList())
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: Colors.red,
                  ),
                ))),
    );
  }
}
