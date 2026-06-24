import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String titleStr;
  Color bgColor;
  Color borderColor;
  Widget? leftIcon;
  VoidCallback? onPress;
  Color textColor;
  double textSize;
  bool isLoader;
  bool isDisable;
  double horizontalMargin;

  CustomButton({
    Key? key,
    this.titleStr = "",
    this.leftIcon,
    this.onPress,
    this.bgColor = ColorsUtil.blueColor,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.isLoader = false,
    this.isDisable = false,
    this.horizontalMargin = 15,
    this.textSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(5),
        color: bgColor != Colors.transparent
            ? bgColor.withOpacity(isDisable ? 0.4 : 1)
            : bgColor,
      ),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoader,
              child: Row(
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 2,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            leftIcon == null ? SizedBox() : leftIcon!,
            Visibility(
              visible: leftIcon != null,
              child: SizedBox(width: 10),
            ),
            Text(
              titleStr,
              style: TextStyle(
                fontFamily: CustomFonts.nunito,
                fontWeight: FontWeight.bold,
                fontSize: textSize,
                color: textColor,
              ),
            ),
          ],
        ),
        onPressed: isDisable ? null : onPress,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          ),
          textStyle: TextStyle(color: Colors.white)
        ),
      ),
    );
  }
}
