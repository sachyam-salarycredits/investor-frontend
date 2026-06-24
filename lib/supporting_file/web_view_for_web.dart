// import 'dart:html';
//
// import 'package:flutter/material.dart';
//
// import 'dart:ui' as ui;
//
// class WebViewForWeb extends StatefulWidget {
//   const WebViewForWeb({Key? key}) : super(key: key);
//
//   @override
//   _WebViewForWebState createState() => _WebViewForWebState();
// }
//
// class _WebViewForWebState extends State<WebViewForWeb> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: HtmlElementView(
//         viewType: "webSip",
//         onPlatformViewCreated: (val){
//         },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     ui.platformViewRegistry.registerViewFactory(
//         'webSip',
//             (int viewId) => IFrameElement()
//           ..width = '100'
//           ..height = '100'
//           ..src = 'https://morioh.com/p/784978c7536f'
//
//           ..style.border = 'none'
//     );
//     super.initState();
//   }
// }
