import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/mine/index.dart';

import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'controller.dart';

class Discovery extends StatefulWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return GetXDiscovery();
  }

  @override
  bool get wantKeepAlive => true; // 保持页面状态
}

class GetXDiscovery extends GetView<DiscoveryController> {
  GetXDiscovery({Key? key}) : super(key: key);

  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // backgroundColor:
        //     GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        // backgroundColor: Colors.black12,
        body: EasyRefresh(
          controller: _refreshController,
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          header: ClassicalHeader(),
          footer: ClassicalFooter(),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1), () async {
              // print('------首页数据清除------');
              // await _onRefrechClear();
              print('------首页数据刷新------');
              await _onRefrechGet();

              _refreshController.resetLoadState();
            });
          },
          // onLoad: () async {
          //   print('onLoad');
          //   await Future.delayed(Duration(seconds: 2), () {
          //     controller.getPlaylisTrack();
          //     _refreshController.finishLoad();
          //   });
          // },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // buildSliverAppBar(),
              buildSwiperBanner(),
              buildRecommendPlaylist(),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '新歌推荐',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              buildNewRecommendedSongs()
            ],
          ),
        ),
      ),
    );
  }

  // 新歌推荐
  SliverList buildNewRecommendedSongs() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var items = controller.trackPlaylist;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.isLoding.value
                  ? Container(
                      margin: const EdgeInsets.only(left: 8.0, bottom: 10.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(items[index]['al']['picUrl']),
                        ),
                      ),
                    )
                  : Shimmer.fromColors(
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      baseColor: Colors.blueAccent,
                      highlightColor: Colors.red,
                    ),
              const SizedBox(width: 12),
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${items[index]['name']}\n',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text('${items[index]['al']['name']}\n'),
                    // RichText(
                    //   overflow: TextOverflow.ellipsis,
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: '${items[index]['name']}\n',
                    //         style: TextStyle(
                    //             color: GlobalService.to.isDarkModel
                    //                 ? Colors.white
                    //                 : Colors.black,
                    //             overflow: TextOverflow.ellipsis),
                    //       ),
                    //       TextSpan(
                    //           text: items[index]['al']['name'],
                    //           style: TextStyle(
                    //               color: GlobalService.to.isDarkModel
                    //                   ? Colors.white
                    //                   : Colors.black,
                    //               overflow: TextOverflow.ellipsis)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          );
        },
        childCount: controller.trackPlaylist.length,
      ),
    );
  }

  // 清楚缓存数据
  _onRefrechClear() async {
    controller.isLoding.value = false;
    controller.swiper.clear();
    controller.netPlaylist.clear();
    controller.trackPlaylist.clear();
  }

  //加载数据
  _onRefrechGet() async {
    controller.swiper.isEmpty ? await controller.getBanners() : print('数据');

    controller.netPlaylist.isEmpty
        ? await controller.getTopPalylist()
        : print('数据');

    controller.trackPlaylist.isEmpty
        ? await controller.getPlaylisTrack()
        : print('数据');

    controller.isLodingData();
  }

  // 新歌推荐(已弃用)
  // SliverToBoxAdapter buildNewRecommendedSongs() {
  //   return SliverToBoxAdapter(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Padding(
  //           padding: EdgeInsets.only(left: 8.0, bottom: 12.0),
  //           child: Text(
  //             '新歌推荐',
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: controller.trackPlaylist
  //               .map((items) => Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       controller.isLoding.value
  //                           ? Container(
  //                               margin: const EdgeInsets.only(
  //                                   left: 8.0, bottom: 10.0),
  //                               height: 100,
  //                               width: 100,
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(12),
  //                                 image: DecorationImage(
  //                                   image: NetworkImage(items['al']['picUrl']),
  //                                 ),
  //                               ),
  //                             )
  //                           : Shimmer.fromColors(
  //                               child: Container(
  //                                 height: 100,
  //                                 width: 100,
  //                                 margin: const EdgeInsets.all(8.0),
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white10,
  //                                   borderRadius: BorderRadius.circular(12.0),
  //                                 ),
  //                               ),
  //                               baseColor: Colors.blueAccent,
  //                               highlightColor: Colors.red,
  //                             ),
  //                       const SizedBox(width: 12),
  //                       Container(
  //                         margin: const EdgeInsets.only(right: 8.0),
  //                         width: 200,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             RichText(
  //                               overflow: TextOverflow.ellipsis,
  //                               text: TextSpan(
  //                                 children: [
  //                                   TextSpan(
  //                                     text: '${items['name']}\n',
  //                                     style: TextStyle(
  //                                         color: GlobalService.to.isDarkModel
  //                                             ? Colors.white
  //                                             : Colors.black,
  //                                         overflow: TextOverflow.ellipsis),
  //                                   ),
  //                                   TextSpan(
  //                                       text: items['al']['name'],
  //                                       // .toString(),
  //                                       style: TextStyle(
  //                                           color: GlobalService.to.isDarkModel
  //                                               ? Colors.white
  //                                               : Colors.black,
  //                                           overflow: TextOverflow.ellipsis)),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ))
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // 推荐歌单(推荐歌单)
  SliverToBoxAdapter buildRecommendPlaylist() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '推荐歌单',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.netPlaylist.length,
                  itemBuilder: (context, index) {
                    var item = controller.netPlaylist;
                    return Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.getSongs("${item[index]['id']}");
                                Get.toNamed(
                                  '/playList',
                                  arguments: item[index],
                                );
                              },
                              child: controller.isLoding.value
                                  ? Hero(
                                      tag: item[index]['id'],
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        margin: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                item[index]['coverImgUrl']),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Shimmer.fromColors(
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      baseColor: Colors.blueAccent,
                                      highlightColor: Colors.red,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            item[index]['name'],
                            // style: TextStyle(
                            //   color: GlobalService.to.isDarkModel
                            //       ? Colors.white
                            //       : Colors.black,
                            // ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
        //已弃用
        // Container(
        //   height: 200,
        //   margin: const EdgeInsets.all(4),
        //   child: Obx(
        //     () => SingleChildScrollView(
        //         physics: const BouncingScrollPhysics(),
        //         scrollDirection: Axis.horizontal,
        //         child: Row(
        //             children: controller.netPlaylist
        //                 .map((e) =>
        //                 Column(
        //                       children: [
        //                         Row(
        //                           children: [
        //                             InkWell(
        //                               onTap: () {
        //                                 controller.getSongs("${e['id']}");
        //                                 Get.to(
        //                                   () => const TopPlaylistSongsPage(),
        //                                   arguments: e,
        //                                 );
        //                               },
        //                               child: controller.isLoding.value
        //                                   ? Hero(
        //                                       tag: e['name'],
        //                                       child: Container(
        //                                         width: 150,
        //                                         height: 150,
        //                                         margin:
        //                                             const EdgeInsets.all(6.0),
        //                                         decoration: BoxDecoration(
        //                                           borderRadius:
        //                                               BorderRadius.circular(
        //                                                   12.0),
        //                                           image: DecorationImage(
        //                                             image: NetworkImage(
        //                                                 e['coverImgUrl']),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                     )
        //                                   : Shimmer.fromColors(
        //                                       child: Container(
        //                                         height: 150,
        //                                         width: 150,
        //                                         margin:
        //                                             const EdgeInsets.all(8.0),
        //                                         decoration: BoxDecoration(
        //                                           color: Colors.white10,
        //                                           borderRadius:
        //                                               BorderRadius.circular(
        //                                                   12.0),
        //                                         ),
        //                                       ),
        //                                       baseColor: Colors.blueAccent,
        //                                       highlightColor: Colors.red,
        //                                     ),
        //                             ),
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           width: 150,
        //                           child: Text(
        //                             e['name'],
        //                             style: TextStyle(
        //                               color: GlobalService.to.isDarkModel
        //                                   ? Colors.white
        //                                   : Colors.black,
        //                             ),
        //                             overflow: TextOverflow.ellipsis,
        //                           ),
        //                         ),
        //                       ],
        //                     ))
        //                 .toList())),
        //   ),
        // ),
      ),
    );
  }

  // 轮播图
  SliverToBoxAdapter buildSwiperBanner() {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 2.5,
        child: controller.isLoding.value
            ? Swiper.children(
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white.withOpacity(0.38),
                    activeColor: Colors.red,
                    size: 7.0,
                    activeSize: 10.0,
                    space: 2.0,
                  ),
                ),
                autoplay: true,
                physics: const BouncingScrollPhysics(),
                children: controller.swiper
                    .map(
                      (element) => Container(
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            element['pic'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList())
            : Shimmer.fromColors(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                baseColor: Colors.blueAccent,
                highlightColor: Colors.red,
              ),
      ),
    );
  }
}
