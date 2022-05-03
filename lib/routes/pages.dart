part of routes;

/// 路由
class AppPages {
  static const initial = AppRoutes.home;
  static List<String> history = [];

  // 路由表
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.playList,
      page: () => TopPlaylistSongsPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
