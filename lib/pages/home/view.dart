import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/pages/home/index.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/discovery/view.dart';
import 'package:get/get.dart';

import '../test.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: _buildAppbar(),
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
  // 顶部导航
  AppBar _buildAppbar() => AppBar(title: const Text("首页"));

  // 内容页
  Widget _buildPageView() => PageView(
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          // Account(),
          Discovery(),
          // Video(),
          // Friends(),
          // Mine(),

          TestPage(),
          TestPage(),
          TestPage(),
          TestPage(),
        ],
      );

  // 底部导航
  Widget _buildBottomNavigationBar() => Obx(() => BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.state.page,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handleNavBarTap,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ));
}
