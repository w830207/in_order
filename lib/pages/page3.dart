import 'package:flutter/material.dart';
import 'package:in_order/services/popup_service3.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  late PopupService3 service;

  @override
  void initState() {
    super.initState();
    service = PopupService3();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () {
            service.popupLevel(1);
            service.popupLevel(2);
            service.popupLevel(3);
            service.popupLevel(4);
            service.popupLevel(5);
          },
          child: const Text("彈窗測試"),
        ),
      ),
    );
  }
}
