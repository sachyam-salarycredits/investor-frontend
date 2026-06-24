import 'dummy_js.dart' if (dart.library.js) 'package:js/js.dart';

@JS("initFlyySdk")
external initFlyySdk(
    String token, String deviceId, String partnerId, String stage);

@JS("initStartReferalTracking")
external initStartReferalTracking();