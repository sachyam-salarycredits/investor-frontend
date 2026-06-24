import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/responsive.dart';
import 'loan_cart_popup.dart';

class LoanCartButton extends StatefulWidget {
  final Function onUpdate;
  final Function refreshData;
  const LoanCartButton({
    Key? key,
    required this.onUpdate,
    required this.refreshData,
  }) : super(
          key: key,
        );

  @override
  LoanCartButtonState createState() => LoanCartButtonState();
}

class LoanCartButtonState extends State<LoanCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  animate() {
    _animationController.forward();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1700));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });

    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);

    var userCartList = provider.getCurrentCart();

    if (userCartList.isEmpty) {
      return SizedBox();
    }

    var startPos = 6.0;
    var endPos = 170.0;
    TweenSequence<double> sequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: startPos, end: endPos), weight: 1),
      TweenSequenceItem(tween: Tween(begin: endPos, end: startPos), weight: 1),
    ]);

    final position = sequence.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeIn)));

    TweenSequence<double> scaleSequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: .5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: .5, end: 1), weight: 1),
    ]);

    TweenSequence<double> scaleBadgeSequence = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 1), weight: 1),
    ]);

    var colorSequence = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(begin: ColorsUtil.blueColorText, end: Colors.white),
          weight: 1),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: ColorsUtil.blueColorText),
          weight: 1),
    ]);

    var colorBadgeSequence = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: Colors.black), weight: 1),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.black, end: Colors.white), weight: 1),
    ]);

    var colorCartSequnce = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: ColorsUtil.blueColorText),
          weight: 1),
      TweenSequenceItem(
          tween: ColorTween(begin: ColorsUtil.blueColorText, end: Colors.white),
          weight: 1),
    ]);

    final scale = scaleSequence.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(.6, 1, curve: Curves.bounceInOut)));

    final contColor = colorSequence.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.bounceInOut)));

    final badgeColor = colorBadgeSequence.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.bounceInOut)));

    final cartColor = colorCartSequnce.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.bounceInOut)));

    final scaleBadge = scaleBadgeSequence.animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.bounceInOut)));

    return Transform.scale(
      scale: scale.value,
      child: GestureDetector(
        onTap: () {
          provider.sendOtpForUser();
          provider.getUserFundDetails();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              // <-- SEE HERE
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
            ),
            constraints: BoxConstraints(
              maxWidth: ResponsiveWidget.isSmallScreen(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * .35,
            ),
            builder: (BuildContext context) => loanCartPopupDialog(
              onUpdate: widget.onUpdate,
              refreshData: widget.refreshData,
            ),
          );
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) => loanCartPopupDialog(
          //     onUpdate: widget.onUpdate,
          //     refreshData: widget.refreshData,
          //   ),
          // );
        },
        child: Container(
          height: 48,
          width: 48,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  right: -4,
                  top: -position.value,
                  child: Transform.scale(
                    scale: scaleBadge.value,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "${userCartList.length}",
                        style: TextStyle(
                            fontSize: 12, color: ColorsUtil.blueColor),
                      ),
                      decoration: BoxDecoration(
                          color: badgeColor.value, shape: BoxShape.circle),
                    ),
                  )),
              Align(
                child: Center(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: cartColor.value,
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: ColorsUtil.blueColorCart, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
