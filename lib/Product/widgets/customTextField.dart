import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomAutoSizeTextMontserrat extends StatelessWidget {
  bool? textalingCentre = false;
  bool? underline;
  bool? mandatory;
  var text;
  int? maxLines;
  double? fontSize;
  FontWeight? fontWeight;
  Color? textColor;

  CustomAutoSizeTextMontserrat(
      {Key? key,
      this.textalingCentre,
      required this.text,
      this.maxLines,
      this.mandatory,
      this.fontSize,
      this.textColor,
      this.fontWeight,
      this.underline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      // text ?? "",
      TextSpan(text: text ?? ""),
      textAlign: textalingCentre == true ? TextAlign.center : null,
      minFontSize: 11,
      maxLines: maxLines ?? 100000,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        color: textColor ?? Colors.black,
        fontSize: fontSize == null ? 12.0 : fontSize! * 1.00,
        decoration: underline != null
            ? underline == true
                ? TextDecoration.underline
                : TextDecoration.none
            : TextDecoration.none,
      ),

      // GoogleFonts.monster(
      //   fontWeight: fontWeight ?? FontWeight.w500,
      //   fontSize: fontSize == null ? 16.0 : fontSize! * 1.00,
      // ),
    );
  }
}
