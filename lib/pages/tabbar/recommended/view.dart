import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class RecommendedView extends GetView<RecommendedController> {
  const RecommendedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Recommended'),
      ),
    );
  }
}
