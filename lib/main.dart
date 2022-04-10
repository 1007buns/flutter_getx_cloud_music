import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/routes/routes.dart';
import 'pages/home/index.dart';
import 'pages/home/view.dart';
import 'package:get/get.dart';

void main() {
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      initialBinding: HomeBinding(),
    );
  }
}
