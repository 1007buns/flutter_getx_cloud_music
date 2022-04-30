import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/global.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeController extends GetxController {
  // tab页标题
  late final List tabTitles;
  // 页控制器
  late final PageController pageController;
  // 底部导航栏项目
  late final List<BubbleBottomBarItem> bottomTabs;
  // 底部导航索引
  final currentIndex = 0.obs;
  // 当前tab页码
  final page = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabTitles = [
      {'icon': Icons.add, 'text': "发现", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "视频", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "我的", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "账号", 'activeIcon': Icons.find_in_page},
    ];
    bottomTabs = tabTitles
        .map(
          (tab) => BubbleBottomBarItem(
            icon: Obx(
              () => Icon(
                tab['icon'],
                color: GlobalService.to.isDarkModel
                    ? Colors.white54
                    : Colors.black54,
              ),
            ),
            title: Shimmer.fromColors(
              loop: 1,
              child: Text('${tab['text']}'),
              baseColor: Colors.red,
              highlightColor: Colors.greenAccent,
            ),
            activeIcon: Icon(tab['activeIcon']),
            backgroundColor: Colors.red,
          ),
        )
        .toList();
    pageController = PageController(initialPage: page.value, keepPage: true);

    bubbleBottomBarItem();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// bubbleBottomBarItem
  void bubbleBottomBarItem() {}

  /// tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  ///tab栏页码切换
  void handlePageChanged(int pageIndex) {
    currentIndex.value = pageIndex;
  }

  void onPageChanged(int? index) {
    page.value = index!;
  }
}
