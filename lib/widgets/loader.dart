import 'package:Monexo/utils/colours_util.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MonexoLoader extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const MonexoLoader({
    Key? key,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      opacity: 0.5,
      color: Colors.black,
      progressIndicator: CircularProgressIndicator(
        color: ColorsUtil.blueColor,
      ),
      child: child,
    );
  }
}
