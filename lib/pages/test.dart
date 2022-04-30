import 'package:flutter/material.dart';
import 'package:flutter_getx_cloud_music/pages/tabbar/discovery/controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../global.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  final DiscoveryController _controller = Get.put(DiscoveryController());

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;
    const double _panelMinSize = 70.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height;
    var isShow = false.obs;
    return Obx(
      () => Scaffold(
        backgroundColor:
            GlobalService.to.isDarkModel ? Colors.black : Colors.white,
        body: Center(
          child: Column(
            children: [
              const Text('这里是测试页面', style: TextStyle(fontSize: 35)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
