import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

import '../global.dart';

import 'controller/play_song_controller.dart';

// ignore: must_be_immutable
class BottomWeSlide extends GetView<PlaySongController> {
  BottomWeSlide({
    Key? key,
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
        backgroundColor:
            GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        panelMinSize: 60.0,
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
          // color: GlobalService.to.isDarkModel ? Colors.black : Colors.white,
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
                      onTap: () async {
                        print('点击了播放按钮${controller.isShow.value}');

                        controller.isShow.value = !controller.isShow.value;
                        controller.isShow.value
                            ? controller.play(controller.songBody[0]['url'])
                            : controller.audioPlayer.pause();
                      },
                      child: controller.isShow.value ? stopIcon : playIcon),
                ],
              ),
              trailing: InkWell(
                  onTap: () {
                    print('播放列表');
                    controller.audioPlayer.pause();
                  },
                  child: const Icon(Icons.list_sharp)),
            ),
          ),
          // const Center(child: Text("Slide to Up ☝️"),
        ),
      ),
    );
  }
}
