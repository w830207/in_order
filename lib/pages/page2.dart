import 'package:flutter/material.dart';
import 'package:in_order/services/popup_service2.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late PopupService2 service;

  @override
  void initState() {
    super.initState();
    service = PopupService2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () {
            service.popupLowLevel();
            service.popupLowLevel();
            service.popupHighLevel();
          },
          child: const Text("彈窗測試"),
        ),
      ),
    );
  }
}
