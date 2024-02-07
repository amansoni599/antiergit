import 'package:antiergit/Product/widgets/customTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategroyText extends StatelessWidget {
  String title;
  CategroyText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomAutoSizeTextMontserrat(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
