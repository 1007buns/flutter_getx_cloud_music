import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

import '../global.dart';
import '../pages/tabbar/discovery/controller.dart';

// ignore: must_be_immutable
class BottomWeSlide extends GetView<DiscoveryController> {
  BottomWeSlide({
    Key? key,
    required this.panelMinSize,
    required this.body,
    this.footer,
    this.appBar,
    this.title = '星河烂漫',
    this.image =
        'https://p1.music.126.net/k2gPfg6jxLIejjJFZdjJZg==/109951165870556526.jpg',
  }) : super(key: key);
  Widget body;
  Widget? footer;
  Widget? appBar;
  double panelMinSize;
  String title, image;
  Icon playIcon = Icon(Icons.play_circle_outline);
  Icon stopIcon = Icon(Icons.stop_circle_outlined);
  WeSlideController _weSlideController = WeSlideController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => WeSlide(
        // footer: footer,
        // footerHeight: 55,
        parallax: true,
        blur: true,
        overlay: true,
        hideAppBar: true,
        controller: _weSlideController,
        // backgroundColor:
        //     GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        panelMinSize: panelMinSize,
        panelMaxSize: size.height,
        body: body,
        appBar: appBar,
        appBarHeight: 120,

        panel: Container(
          color: GlobalService.to.isDarkModel ? Colors.black : Colors.white,
          child: const Center(
            child: Text(
              "这里是歌曲详情页面 😊",
              // style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        panelHeader: Container(
          height: 60.0,
          color: GlobalService.to.isDarkModel ? Colors.black : Colors.white,
          child: InkWell(
            highlightColor: Colors.blueAccent,
            onTap: () {
              _weSlideController.show();
            },
            child: ListTile(
              leading: Image.network(
                image,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  InkWell(
                      highlightColor: Colors.black,
                      onTap: () {
                        controller.isShow.value = !controller.isShow.value;
                        print('点击了播放按钮${controller.isShow.value}');
                      },
                      child: controller.isShow.value ? stopIcon : playIcon),
                ],
              ),
              trailing: InkWell(
                  onTap: () {
                    print('播放列表');
                  },
                  child: const Icon(Icons.list_sharp)),
              // subtitle: const Text('许嵩'),
            ),
          ),
          // const Center(child: Text("Slide to Up ☝️"),
        ),
      ),
    );
  }
}
