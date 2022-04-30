import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/global.dart';
import 'package:flutter_getx_cloud_music/routes/routes.dart';
import 'package:flutter_getx_cloud_music/style/theme.dart';
import 'pages/home/index.dart';
import 'package:get/get.dart';

void main() {
  // runApp(const MyApp());
  appInit();
}

appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  // service
  Get.put<GlobalService>(GlobalService());
  // 启动app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: GlobalService.to.isDarkModel ? AppTheme.dark : AppTheme.light,
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      initialBinding: HomeBinding(),
    );
  }
}
