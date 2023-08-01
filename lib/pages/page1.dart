import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:in_order/services/popup_service1.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late PopupService1 service;

  @override
  void initState() {
    super.initState();
    service = PopupService1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                BotToast.showSimpleNotification(title: "無排序");
                BotToast.showSimpleNotification(title: "無排序");
              },
              child: const Text("無排序"),
            ),
            TextButton(
              onPressed: () {
                service.popup();
                service.popup();
              },
              child: const Text("有排序"),
            ),
          ],
        ),
      ),
    );
  }
}
