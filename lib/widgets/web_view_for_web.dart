// import 'dart:html';
//
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
//
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
//   @override
//   void initState() {
//
//     ui.platformViewRegistry.registerViewFactory(
//         'web_view',
//             (int viewId) => IFrameElement()
//           ..width = '100%'
//           ..height = '100%'
//           ..src = 'https://test.lotuspay.com/pay/AL0072K4B4TBSY?client_secret=src_client_secret_eAFXRiQ7qTUidPCRQUYUanNc'
//           ..style.border = 'none');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return HtmlElementView(viewType: "web_view",onPlatformViewCreated: (id){
//
//     },);
//   }
// }
//
//
//
