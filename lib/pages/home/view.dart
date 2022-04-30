import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/global.dart';
import 'package:flutter_getx_cloud_music/pages/home/index.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/discovery/view.dart';
import 'package:flutter_getx_cloud_music/widgets/bottom_we_slide.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';
import '../test.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => GlobalService.to.switchThemeModel(),
          ),
        ],
      ),
      body: BottomWeSlide(
        body: _buildPageView(),
        panelMinSize: 100.0,
        footer: _buildBottomNavigationBar(),
      ),
    );
  }

  /// 已弃用
  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       body: _buildPageView(),
  //       bottomNavigationBar: _buildBottomNavigationBar(),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () => GlobalService.to.switchThemeModel(),
  //         // tooltip: 'Increment',
  //         child: Obx(
  //           () => Icon(
  //             GlobalService.to.isDarkModel ? Icons.dark_mode : Icons.light_mode,
  //           ),
  //         ),
  //       ),
  //     );

  // 内容页
  Widget _buildPageView() => PageView(
        controller: controller.pageController,

        onPageChanged: (index) {
          // controller.pageController.jumpToPage(index);
          controller.pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad);
        },
        // physics: const NeverScrollableScrollPhysics(),
        children: const [
          // Account(),
          Discovery(),
          // Video(),
          // Friends(),
          // Mine(),

          // TestPage(),
          TestPage(),
          TestPage(),
          TestPage(),
        ],
      );

  // 底部导航
  Widget _buildBottomNavigationBar() => Obx(
        () => BubbleBottomBar(
          tilesPadding: const EdgeInsets.all(5),
          opacity: .2,
          elevation: 0.0,
          hasNotch: true,
          hasInk: true,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.handlePageChanged(index!);
            controller.pageController.jumpToPage(index);
          },
          items: controller.bottomTabs,
          backgroundColor:
              GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        ),
      );
}
