import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mine extends StatelessWidget {
  const Mine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('账号'),
        elevation: 0.0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (() => Get.back()),
            child: const Hero(
              tag: 'flutter_dash',
              child: Icon(
                Icons.flutter_dash,
                size: 200,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '萌萌  I  LOVE YOU !!!',
            style: TextStyle(fontSize: 30),
          )
        ],
      )),
    );
  }
}
