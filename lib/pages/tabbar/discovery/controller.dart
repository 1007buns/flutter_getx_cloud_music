import 'dart:convert';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_method.dart';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_response.dart';
import 'package:flutter_getx_cloud_music/utils/dio_util/dio_util.dart';
import 'package:get/get.dart';

class DiscoveryController extends GetxController {
  var isLoding = false.obs;
  var isShow = false.obs;
  List swiper = [].obs;
  List netPlaylist = [].obs;
  List trackPlaylist = [].obs;
  List songsPlaylist = [].obs;

  void getSongs(String id) async {
    if (songsPlaylist.isNotEmpty) {
      songsPlaylist.clear();
      getPlaylistSongs(id);
    } else {
      getPlaylistSongs(id);
      // update();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getBanners();
    await getTopPalylist();
    await getPlaylisTrack();

    isLodingData();
  }

  void isLodingData() {
    if (swiper.isNotEmpty &&
        netPlaylist.isNotEmpty &&
        trackPlaylist.isNotEmpty) {
      isLoding.value = true;
    }
    // isLoding.value = true;
  }

  /// 获取/banner数据
  Future<void> getBanners() async {
    DioResponse res = await DioUtil().request(
      '/banner',
      method: DioMethod.get,
      params: {"type": 1},
    );

    Map<String, dynamic> data = jsonDecode(res.data);
    List banners = data['banners'];

    if (res.code == 0) {
      // ignore: avoid_function_literals_in_foreach_calls
      print('获取首页轮播图');
      banners.forEach((items) => swiper.add(items));
      // swiper.add(data['banners']);
      // isLoding.value = true;
    } else {
      getBanners();
    }
  }

  /// 歌单 ( 网友精选碟 ) /top/playlist/highquality&limit=3
  Future<void> getTopPalylist() async {
    DioResponse res = await dioUtil.request('/top/playlist/highquality&limit=3',
        params: {'cat': '华语'}, method: DioMethod.get);

    Map<String, dynamic> data = jsonDecode(res.data);
    List topPlaylist = data['playlists'];

    if (res.code == 0) {
      topPlaylist.forEach((items) => netPlaylist.add(items));
      print('获取推荐歌单');
      // isLoding.value = true;
    } else {
      print('getTopPalylist() 重新获取');
      getTopPalylist();
    }
  }

  /// 获取新歌推荐 /playlist/track/all?id=610040691&limit=10&offset=1
  Future<void> getPlaylisTrack() async {
    DioResponse res = await dioUtil.request(
      '/playlist/track/all?id=610040691',
      method: DioMethod.get,
    );
    var data;
    data = jsonDecode(res.data);
    // print(data);
    List playlistTrack = data['songs'];
    if (res.code == 0) {
      print('获取新歌推荐歌曲成功');
      playlistTrack.forEach((items) => trackPlaylist.add(items));
      // print(trackPlaylist[1]['name'])
      // isLoding.value = true;
    } else {
      print('getPlaylisTrack() 重新获取数据');
      getPlaylisTrack();
    }
  }

  // 获取歌单数据 /playlist/track/all?id=5028497628&limit=10&offset=1
  Future<void> getPlaylistSongs(String id) async {
    print('获取歌单id: $id 数据');
    DioResponse res = await dioUtil.request(
      '/playlist/track/all?id=$id',
      method: DioMethod.get,
    );
    var data;
    data = jsonDecode(res.data);
    // print(data);
    List playlistSongs = data['songs'];
    if (res.code == 0) {
      print('获取歌单数据成功');
      playlistSongs.forEach((items) => songsPlaylist.add(items));
      print(songsPlaylist);
      update();
      // isLoding.value = true;
    } else {
      print('重新获取歌单数据');
      getPlaylistSongs(id);
    }
  }
}
