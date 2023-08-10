import 'package:flutter/material.dart';
import 'package:in_order/pages/page1.dart';
import 'package:in_order/pages/page2.dart';
import 'package:in_order/pages/page3.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const Page1();
                  }),
                );
              },
              child: const Text("基本"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const Page2();
                  }),
                );
              },
              child: const Text("升級: 雙等級優先度"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const Page3();
                  }),
                );
              },
              child: const Text("升級: 多等級優先度"),
            ),
          ],
        ),
      ),
    );
  }
}
