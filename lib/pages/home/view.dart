import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/global.dart';
import 'package:flutter_getx_cloud_music/pages/home/index.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/discovery/view.dart';
import 'package:flutter_getx_cloud_music/widgets/bottom_we_slide.dart';
import 'package:get/get.dart';
import '../tabbar/mine/view.dart';
import '../tabbar/recommended/view.dart';
import '../test.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final HomeController _controller = Get.put(HomeController());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _controller.tabValues.length, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomWeSlide(
        appBar: AppBar(
          elevation: 0.0,
          bottom: buildTabBar(),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => GlobalService.to.switchThemeModel(),
            ),
          ],
        ),
        body: buildTabBarView(),
        panelMinSize: 60.0,
        // footer: _buildBottomNavigationBar(),
      ),
    );
  }

// Tab栏
  TabBar buildTabBar() {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      tabs: _controller.tabs,
      controller: _tabController,
    );
  }

// Tab内容页
  TabBarView buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        MineView(),
        Discovery(),
        RecommendedView(),
      ],
    );
  }

  // 内容页
  Widget _buildPageView() => PageView(
        controller: _controller.pageController,
        onPageChanged: (index) {
          _controller.pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad);
        },
        children: const [
          Discovery(),
          TestPage(),
          TestPage(),
          TestPage(),
        ],
      );
}

// class GetXHomePage extends GetView<HomeController> {
//   GetXHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BottomWeSlide(
//         appBar: AppBar(
//           elevation: 0.0,
//           bottom: TabBar(
//             tabs: controller.tabs,
//             controller: controller.tabController,
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () => GlobalService.to.switchThemeModel(),
//             ),
//           ],
//         ),
//         body: TabBarView(
//           controller: controller.tabController,
//           children: const [
//             Discovery(),
//             TestPage(),
//             TestPage(),
//             TestPage(),
//           ],
//         ),
//         panelMinSize: 60.0,
//         // footer: _buildBottomNavigationBar(),
//       ),
//     );
//   }

//   // 内容页
//   Widget _buildPageView() => PageView(
//         controller: controller.pageController,
//         onPageChanged: (index) {
//           controller.pageController.animateToPage(index,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeOutQuad);
//         },
//         children: const [
//           Discovery(),
//           TestPage(),
//           TestPage(),
//           TestPage(),
//         ],
//       );

//   // 底部导航
//   // Widget _buildBottomNavigationBar() => Obx(
//   //       () => BubbleBottomBar(
//   //         tilesPadding: const EdgeInsets.all(5),
//   //         opacity: .2,
//   //         elevation: 0.0,
//   //         hasNotch: true,
//   //         hasInk: true,
//   //         currentIndex: controller.currentIndex.value,
//   //         onTap: (index) {
//   //           controller.handlePageChanged(index!);
//   //           controller.pageController.jumpToPage(index);
//   //         },
//   //         items: controller.bottomTabs,
//   //         backgroundColor:
//   //             GlobalService.to.isDarkModel ? Colors.black : Colors.white,
//   //       ),
//   //     );
// }
