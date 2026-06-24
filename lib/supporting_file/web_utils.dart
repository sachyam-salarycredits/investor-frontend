import 'dummy_js.dart' if (dart.library.js) 'package:js/js.dart';
import 'dummy_js.dart' if (dart.library.js) 'package:js/js_util.dart';

@JS("closeWin")
external closeWindow();

@JS("openWin")
external openWebWindow(String url);

@JS("addEvent")
external addReloadEvent(reloadCallback);