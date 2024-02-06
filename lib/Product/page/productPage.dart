import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [...widgetList(), loading()],
    ));
  }

  Widget loading() {
    waitforLoader();
    return const CircularProgressIndicator();
  }

  List<Widget> widgetList() {
    List<Widget> list = [];
    for (var i = 0; i < 20; i++) {
      list.add(const SizedBox(height: 40, width: 40, child: Text("Hello")));
    }
    return list;
  }

  waitforLoader() async {
    print("object");
    await Future.delayed(const Duration(seconds: 5));
  }
}
