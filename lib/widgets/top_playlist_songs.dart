import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/discovery/controller.dart';
import 'package:flutter_getx_cloud_music/widgets/bottom_we_slide.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../global.dart';

class TopPlaylistSongsPage extends GetView<DiscoveryController> {
  const TopPlaylistSongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 1;
    return Obx(
      () => Scaffold(
        // backgroundColor:
        //     GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        body: CustomScrollView(
          primary: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            buildAppBar(),
            buildSongsListIntroduce(),
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(),
            ),
            buildSongPlaylist(),
          ],
        ),
      ),
    );
  }

// 歌单歌曲列表
  SliverList buildSongPlaylist() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        var item = controller.songsPlaylist;
        return ListTile(
          leading: Text('${index + 1}'),
          title: InkWell(
              child: Text('${item[index]['name']}'),
              onTap: () {
                print('音乐id:${item[index]['id']}');
              }),
          subtitle: Text('${item[index]['ar'][0]['name']}'),
          trailing: const Icon(Icons.more_vert),
        );
      }, childCount: controller.songsPlaylist.length),
    );
  }

// 歌单介绍
  SliverToBoxAdapter buildSongsListIntroduce() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Hero(
                  tag: Get.arguments['id'],
                  child: Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(Get.arguments['coverImgUrl']),
                      ),
                    ),
                  ),
                )),
            const SizedBox(width: 10.0),
            Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 150,
                  width: 180,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        '${Get.arguments['description']}',
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// AppBar
  Obx buildAppBar() {
    return Obx(
      () => SliverAppBar(
        pinned: true,
        elevation: 0.0,
        backgroundColor:
            GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        title: Text('${Get.arguments['name']}'),
      ),
    );
  }

  // 已弃用
  // Obx buildPlayAllSliverBar() {
  //   return Obx(
  //     () => SliverAppBar(
  //       pinned: true,
  //       elevation: 0.0,
  //       backgroundColor:
  //           GlobalService.to.isDarkModel ? Colors.black : Colors.white,
  //       leading: const Icon(Icons.play_circle),
  //       title: Obx(() => Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               const Text("播放全部"),
  //               const SizedBox(width: 5.0),
  //               Text(
  //                 "(${controller.songsPlaylist.length})",
  //                 style: const TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           )),
  //       actions: const [
  //         Icon(Icons.cloud_download_rounded),
  //         SizedBox(width: 20),
  //         Icon(Icons.download_done),
  //       ],
  //     ),
  //   );
  // }

// // 歌单歌曲列表(弃用)
//   Obx buildSongPlaylist(int counter) {
//     return Obx(
//       (() => SliverToBoxAdapter(
//             child: Column(
//               children: controller.songsPlaylist
//                   .map(
//                     (e) => ListTile(
//                       leading: Text('${counter++}'),
//                       title: Text('${e['name']}'),
//                       subtitle: Text('${e['ar'][0]['name']}'),
//                       trailing: const Icon(Icons.more_vert),
//                     ),
//                   )
//                   .toList(),
//             ),
//           )),
//     );
//   }

}

// MySliverPersistentHeader
class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DiscoveryController _controller = Get.put(DiscoveryController());
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(
      () => ListTile(
        leading: const Icon(Icons.play_circle),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("播放全部"),
            const SizedBox(width: 5.0),
            Text(
              "(${_controller.songsPlaylist.length})",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.sort,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
