import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class PdfViewWidget extends StatelessWidget {
  final String url;
  const PdfViewWidget({Key? key , required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WebViewX(width: size.width, height: size.height,
    initialContent: url,initialSourceType: SourceType.url,);
  }
}
