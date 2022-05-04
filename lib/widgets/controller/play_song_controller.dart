import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../../utils/dio_util/dio_method.dart';
import '../../utils/dio_util/dio_response.dart';
import '../../utils/dio_util/dio_util.dart';

class PlaySongController extends GetxController {
  var isShow = false.obs;
  List songsPlaylist = [].obs;
  List songBody = [].obs;

  var id = 0.obs;

  void getSongs(String id) async {
    if (songsPlaylist.isNotEmpty) {
      songsPlaylist.clear();
      getPlaylistSongs(id);
    } else {
      getPlaylistSongs(id);
      // update();
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();
  void play(String url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      print('播放音乐');
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
      // isLoding.value = true;
    } else {
      print('重新获取歌单数据');
      getPlaylistSongs(id);
    }
  }

// 获取歌曲数据
  Future<void> getSongUrl(int id) async {
    DioResponse res = await dioUtil.request(
      '/song/url',
      method: DioMethod.get,
      params: {'id': '$id'},
    );
    var data;
    data = jsonDecode(res.data);

    print(songBody);
    if (res.code == 0) {
      print('获取歌曲:$id 数据成功');
      songBody = data['data'];
      print('歌曲数据: $songBody');
      update();
    } else {
      getSongUrl(id);
    }
  }
}
