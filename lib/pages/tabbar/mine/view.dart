import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MineView extends GetView<MineController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MineView'),
      ),
    );
  }
}
