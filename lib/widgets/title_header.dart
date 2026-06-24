import 'package:Monexo/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/widgets/custom_button.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
// import 'package:Monexo/routes_management/app_router.dart';
// import 'package:Monexo/routes_management/routes_list.dart';

class TitleHeader extends StatelessWidget {
  Color bgColor;
  String titleStr;
  String desStr;
  bool? isVisibleSwitch;
  bool? switchValue;
  Function(bool)? onChange;

  TitleHeader({
    Key? key,
    this.bgColor = Colors.white,
    this.titleStr = '',
    this.desStr = '',
    this.onChange,
    this.switchValue = false,
    this.isVisibleSwitch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleStr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: CustomFonts.nunito,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              if (isVisibleSwitch ?? false)
                FlutterSwitch(
                  activeColor: ColorsUtil.blueColor,
                  width: 50.0,
                  height: 25.0,
                  // valueFontSize: 25.0,
                  toggleSize: 20.0,
                  value: switchValue ?? false,
                  borderRadius: 30.0,
                  // padding: 8.0,
                  // showOnOff: true,
                  onToggle: (val) {
                    if (onChange != null) {
                      onChange!(val);
                    }
                  },
                )
            ],
          ),
          SizedBox(height: 10),
          Text(
            desStr,
            style: TextStyle(
              fontFamily: CustomFonts.nunito,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
