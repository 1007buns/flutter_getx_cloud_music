import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/pages/home/state.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final state = HomeState();
  // tab页标题
  late final List tabTitles;
  // 页控制器
  late final PageController pageController;
  // 底部导航栏项目
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    tabTitles = [
      {'icon': Icons.add, 'text': "发现", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "视频", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "我的", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "朋友", 'activeIcon': Icons.find_in_page},
      {'icon': Icons.add, 'text': "账号", 'activeIcon': Icons.find_in_page},
    ];
    bottomTabs = tabTitles
        .map(
          (tab) => BottomNavigationBarItem(
            icon: Icon(tab['icon']),
            label: tab['text'],
            activeIcon: Icon(tab['activeIcon']),
            backgroundColor: Colors.black,
          ),
        )
        .toList();

    //    BottomNavigationBarItem(
    //    icon: Icon(
    //     Iconfont.me,
    //     color: AppColor.defaultColor,
    //    ),
    //    activeIcon: Icon(
    //     Iconfont.me,
    //     color: AppColor.activeColor,
    //    ),
    //    label: 'my',
    //    backgroundColor: AppColor.primaryBackground,
    // ),

    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }
}
