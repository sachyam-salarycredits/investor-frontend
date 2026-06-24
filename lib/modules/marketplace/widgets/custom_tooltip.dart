import 'package:flutter/material.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';

class CustomTooltip extends StatefulWidget {
  final String message;
  final Widget child;

  const CustomTooltip(
      {required Key key, required this.child, required this.message})
      : super(key: key);

  @override
  CustomTooltipState createState() => CustomTooltipState();
}

class CustomTooltipState extends State<CustomTooltip>
    with TickerProviderStateMixin {
  final color = Colors.redAccent;
  late GlobalKey key;
  late Offset _offset;
  late Size _size;
  late OverlayEntry overlayEntry;
  String message = "";

  late AnimationController _controller;

  @override
  void initState() {
    key = LabeledGlobalKey(widget.message);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

        Future.delayed(Duration(seconds: 2)).then((value){
          overlayEntry.remove();
          _controller.reverse();
        });
      }
    });
    super.initState();
  }

  void getWidgetDetails() {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    _size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    _offset = offset;
    print(_offset.dx);
  }

  OverlayEntry makeOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: _offset.dy - _size.longestSide,
        left: _offset.dx*0.9,
        width: _size.width*1.2,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(0, 0.4, curve: Curves.decelerate))),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                        fontFamily: CustomFonts.nunito,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipPath(
                    clipper: ArrowClip(),
                    child: Container(
                      height: 10,
                      width: 15,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMessage(String m) {
    message = m;
    getWidgetDetails();
    overlayEntry = makeOverlay();
    Overlay.of(context)!.insert(overlayEntry);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: key, child: widget.child);
    // return InkWell(
    //   key: key,
    //   child:
    //  // onTap: () {},
    //   // onHover: (v) {
    //   //   if (v) {
    //   //     getWidgetDetails();
    //   //     overlayEntry = makeOverlay();
    //   //     Overlay.of(context)!.insert(overlayEntry);
    //   //     _controller.forward();
    //   //   } else {
    //   //     _controller.reverse();
    //   //     overlayEntry.remove();
    //   //   }
    //   // },
    // );
  }
}

class ArrowClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
