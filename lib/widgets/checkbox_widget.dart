import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  String titleStr;
  VoidCallback onPress;
  bool isSelected;
  bool? isUPIBox;
  Widget? UPIWidget;

  CheckBoxWidget(
      {Key? key,
      this.titleStr = '',
      required this.onPress,
      this.isSelected = false,
      this.isUPIBox,
      this.UPIWidget})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onPress,
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        // widget.isSelected
                        //     ? ColorsUtil.blueColor
                        //     :
                        ColorsUtil.lightestGrey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color:
                    // widget.isSelected
                    //     ? Colors.blue.shade50
                    //     :
                    ColorsUtil.lightestGrey,
              ),
              height:
                  ((widget.isUPIBox ?? false) && widget.isSelected) ? 130 : 56,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Visibility(
                          child: Theme(
                        data: Theme.of(context).copyWith(
                          disabledColor: ColorsUtil.blueColor,
                        ),
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorsUtil.blueColor,
                                  // widget.isSelected
                                  //     ? ColorsUtil.blueColor
                                  //     : ColorsUtil.lighterGrey,
                                  width: 1.8),
                              borderRadius: BorderRadius.circular(60)),
                          child: Center(
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: widget.isSelected
                                      ? ColorsUtil.blueColor
                                      : ColorsUtil.lightestGrey,
                                  border: Border.all(
                                      color: widget.isSelected
                                          ? ColorsUtil.white
                                          : ColorsUtil.lightestGrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(60)),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.titleStr,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: CustomFonts.nunito,
                                fontSize: 15,
                                color: widget.isSelected
                                    ? ColorsUtil.blueColor
                                    : ColorsUtil.black,fontWeight:widget.isSelected
                                  ?FontWeight.w700:FontWeight.normal,
                              ),
                            ),
                            (widget.isUPIBox ?? false)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      '(Recommended)',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: CustomFonts.nunito,
                                        fontSize: 11,
                                        color: ColorsUtil.lighterGrey,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ((widget.isUPIBox ?? false) && widget.isSelected)
                        ? 15
                        : 0,
                  ),
                  ((widget.isUPIBox ?? false) && widget.isSelected)
                      ? widget.UPIWidget ?? Container()
                      : Container()
                ],
              )),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
