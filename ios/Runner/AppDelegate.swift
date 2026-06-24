import UIKit
import Flutter
import MarketingCloudSDK
import AppTrackingTransparency

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let appId = "4802ce88-90b6-4650-b601-5ddc6c551b98"
    let accessToken = "9s09xDWfePVBkc90fz8yrmXC"
    let appEndpoint = "https://mcnr5zh6qqbhr01jtprndxb74nry.device.marketingcloudapis.com/"
    let mid = "526001950"
    let inbox = false
    let location = false
    let analytics = true
    
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        self.configureMarketingCloudSDK()
        
        
        
        
        
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let navController = UINavigationController(rootViewController: flutterViewController);
        navController.setNavigationBarHidden(true, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
        
        
        
        let sfmcChannel = FlutterMethodChannel(name: "sfmc_flutter",
                                               binaryMessenger: flutterViewController.binaryMessenger)
        
        sfmcChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            // Handle battery messages.
            
            self.handle(call, result: result);
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                print("Apps Flyer traking status is \(status)")
            }
        }
    }

    
    func configureMarketingCloudSDK() {
        let builder = MarketingCloudSDKConfigBuilder()
            .sfmc_setApplicationId(appId)
            .sfmc_setAccessToken(accessToken)
            .sfmc_setMarketingCloudServerUrl(appEndpoint)
            .sfmc_setMid(mid)
            .sfmc_setDelayRegistration(untilContactKeyIsSet: true)
            .sfmc_build()!
        
        do {
            try MarketingCloudSDK.sharedInstance().sfmc_configure(with:builder)
            registerForRemoteNotification()
        } catch let error as NSError {
            
        }
    }
    
    
    
    //    func configureMarketingCloudSDK() {
    //        if let url = URL(string: appEndpoint) {
    //            let mobilePushConfiguration = PushConfigBuilder(appId: appId)
    //                .setAccessToken(accessToken)
    //                .setMarketingCloudServerUrl(url)
    //                .setMid(mid)
    //                .setInboxEnabled(inbox)
    //                .setLocationEnabled(location)
    //                .setAnalyticsEnabled(analytics)
    //                .build()
    //
    //            // Set the completion handler to take action when module initialization is completed. The result indicates if initialization was sucesfull or not.
    //            // Seting the completion handler is optional.
    //            let completionHandler: (OperationResult) -> () = { result in
    //                if result == .success {
    //                    // module is fully configured and ready for use
    //                    print("SFMC configured successfully")
    //                } else if result == .error {
    //                    // module failed to initialize, check logs for more details
    //                    print("SFMC got error \(result)")
    //                } else if result == .cancelled {
    //                    // module initialization was cancelled (for example due to re-confirguration triggered before init was completed)
    //                    print("SFMC got cancelled \(result)")
    //                } else if result == .timeout {
    //                    // module failed to initialize due to timeout, check logs for more details
    //                    print("SFMC init timeOut \(result)")
    //                }
    //            }
    //
    //            // Once you've created the mobile push configuration, intialize the SDK.
    //            SFMCSdk.initializeSdk(ConfigBuilder().setPush(config: mobilePushConfiguration, onCompletion: completionHandler).build())
    //        }
    //    }
    //
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MarketingCloudSDK.sharedInstance().sfmc_setDeviceToken(deviceToken)
    }
    
    
    
//     override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//         completionHandler([.alert, .badge, .sound])
//     }
//
//     override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
// //        if let messageID = userInfo[gcmMessageIDKey] {
// //            print("Message ID: \(messageID)")
// //        }
//         print("My notification info is")
//         print(userInfo)
//
//     }
//
//     override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//         print("this called")
//         print(response.notification.request.content.userInfo)
//         print(response.notification.request.content)
//     }
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in

            }
            UIApplication.shared.registerForRemoteNotifications()
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    override func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        if(!MarketingCloudSDK.sharedInstance().sfmc_isReady()) {
            self.configureMarketingCloudSDK()
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if call.method == "setupSFMC" {
            guard let args = call.arguments as? [String : Any] else {return}
            
            let appId = args["appId"] as? String
            let accessToken = args["accessToken"] as? String
            let mid = args["mid"] as? String
            let sfmcURL = args["sfmcURL"] as? String
            let locationEnabled = args["locationEnabled"] as? Bool
            let inboxEnabled = args["inboxEnabled"] as? Bool
            let analyticsEnabled = args["analyticsEnabled"] as? Bool
            let delayRegistration = args["delayRegistration"] as? Bool
            
            if appId == nil || accessToken == nil || mid == nil || sfmcURL == nil {
                result(false)
                return
            }
            
            setupSFMC(appId: appId!, accessToken: accessToken!, mid: mid!, sfmcURL: sfmcURL!, locationEnabled: locationEnabled, inboxEnabled: inboxEnabled, analyticsEnabled: analyticsEnabled, delayRegistration: delayRegistration, onDone: { sfmcResult, message, code in
                if (sfmcResult) {
                    result(true)
                } else {
                    result(FlutterError(code: "\(code!)",
                                        message: message,
                                        details: nil))
                }
            })
        } else if call.method == "setDeviceToken" {
            guard let args = call.arguments as? [String : Any] else {return}
            let deviceKey = args["deviceId"] as! String?
            if deviceKey == nil {
                result(false)
                return
            }
            result(setDeviceKey(deviceKey: deviceKey!))
        } else if call.method == "getDeviceToken" {
            result(getDeviceToken())
        } else if call.method == "getDeviceIdentifier" {
            result(getDeviceIdentifier())
        } else if call.method == "setContactKey" {
            guard let args = call.arguments as? [String : Any] else {return}
            let cKey = args["cId"] as! String?
            if cKey == nil {
                result(false)
                return
            }
            
            result(setContactKey(contactKey: cKey!))
        } else if call.method == "setTag" {
            
            guard let args = call.arguments as? [String : Any] else {return}
            let tag = args["tag"] as! String?
            if tag == nil {
                result(false)
                return
            }
            
            result(setTag(tag: tag!))
        } else if call.method == "removeTag" {
            guard let args = call.arguments as? [String : Any] else {return}
            let tag = args["tag"] as! String?
            if tag == nil {
                result(false)
                return
            }
            result(removeTag(tag:tag!))
        } else if call.method == "setAttribute" {
            guard let args = call.arguments as? [String : Any] else {return}
            let attrName = args["name"] as! String?
            let attrValue = args["value"] as! String?
            if attrName == nil || attrValue == nil {
                result(false)
                return
            }
            result(setAttribute(name: attrName!, value: attrValue!));
        } else if call.method == "clearAttribute" {
            guard let args = call.arguments as? [String : Any] else {return}
            let attrName = args["name"] as! String?
            
            if attrName == nil
            {
                result(false)
                return
            }
            result(clearAttribute(name: attrName!));
            
        }else if call.method == "pushEnabled" {
            result(pushEnabled());
        }else if call.method == "enablePush" {
            result(setPushEnabled(status: true));
        } else if call.method == "disablePush" {
            result(setPushEnabled(status: false));
        } else if call.method == "sdkState" {
            result(getSDKState())
        } else if call.method == "enableVerbose" {
            result(setupVerbose(status: true))
        } else if call.method == "disableVerbose" {
            result(setupVerbose(status: false))
        } else if call.method == "enableWatchingLocation" {
            result(enableLocationWatching())
        } else if call.method == "disableWatchingLocation" {
            result(disableLocationWatching())
        } else {
            result(FlutterError(code: "METHOD_NOT_AVAILABLE",
                                message: "METHOD_NOT_ALLOWED",
                                details: nil))
        }
    }
    
    
    public func setupSFMC(appId: String, accessToken: String, mid: String, sfmcURL: String, locationEnabled: Bool?, inboxEnabled: Bool?, analyticsEnabled: Bool?, delayRegistration: Bool?, onDone: (_ result: Bool, _ message: String?, _ code: Int?) -> Void) {
        MarketingCloudSDK.sharedInstance().sfmc_tearDown()
        
        let builder = MarketingCloudSDKConfigBuilder()
            .sfmc_setApplicationId(appId)
            .sfmc_setAccessToken(accessToken)
            .sfmc_setMarketingCloudServerUrl(sfmcURL)
            .sfmc_setMid(mid)
            .sfmc_setDelayRegistration(untilContactKeyIsSet: (delayRegistration ?? false) as NSNumber)
            .sfmc_setInboxEnabled((inboxEnabled ?? true) as NSNumber)
            .sfmc_setLocationEnabled((locationEnabled ?? true)  as NSNumber)
            .sfmc_setAnalyticsEnabled((analyticsEnabled ?? true)  as NSNumber)
            .sfmc_build()!
        
        //        MarketingCloudSDK.sharedInstance().sfmc_setURLHandlingDelegate(self)
        //        MarketingCloudSDK.sharedInstance().sfmc_setEventDelegate(MarketingCloudSDKEventDelegate?)
        
        do {
            try MarketingCloudSDK.sharedInstance().sfmc_configure(with:builder)
            onDone(true, nil, nil);
        } catch let error as NSError {
            onDone(false, error.localizedDescription, error.code);
        }
    }
    
    /*
     * Device Key Management
     */
    public func setDeviceKey(deviceKey: String) -> Bool? {
        let data = deviceKey.data(using: .utf8)
        if (data == nil) {
            return true
        }
        
        MarketingCloudSDK.sharedInstance().sfmc_setDeviceToken(data!)
        return true
    }
    public func getDeviceToken() -> String? {
        return MarketingCloudSDK.sharedInstance().sfmc_deviceToken()
    }
    public func getDeviceIdentifier() -> String? {
        return MarketingCloudSDK.sharedInstance().sfmc_deviceIdentifier()
    }
    
    
    /*
     * Contact Key Management
     */
    public func setContactKey(contactKey: String) -> Bool? {
        MarketingCloudSDK.sharedInstance().sfmc_setContactKey(contactKey)
        return true
    }
    
    
    /*
     * Attribute Management
     */
    public func setAttribute(name: String, value: Any) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_setAttributeNamed(name, value: "\(value)")
        return true
    }
    public func clearAttribute(name: String) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_clearAttributeNamed(name)
        
        return true
    }
    public func attributes() -> [String: String] {
        return  (MarketingCloudSDK.sharedInstance().sfmc_attributes() ?? [:]) as! [String : String]
    }
    
    /*
     * TAG Management
     */
    public func setTag(tag: String) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_addTag(tag)
        return true
    }
    public func removeTag(tag: String) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_removeTag(tag)
        return true
    }
    public func tags() -> [String] {
        //var tags: [String] = Array(MarketingCloudSDK.sharedInstance().sfmc_tags()!)
        return []
    }
    
    /*
     * Verbose Management
     */
    public func setupVerbose(status: Bool) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_setDebugLoggingEnabled(status)
        return true
    }
    
    /*
     * Verbose Management
     */
    public func pushEnabled() -> Bool {
        return MarketingCloudSDK.sharedInstance().sfmc_pushEnabled()
    }
    public func setPushEnabled(status: Bool) -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_setPushEnabled(status)
        return true
    }
    
    /*
     * SDKState Management
     */
    public func getSDKState() -> String {
        return "SDK State = \(MarketingCloudSDK.sharedInstance().sfmc_getSDKState() ?? "SDK State is nil")"
    }
    
    /*
     * Location
     */
    public func enableLocationWatching() -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_startWatchingLocation()
        return true;
    }
    public func disableLocationWatching() -> Bool {
        MarketingCloudSDK.sharedInstance().sfmc_stopWatchingLocation()
        return true;
    }
    
    
    /*
     * URL Handling
     */
    
    @objc(sfmc_handleURL:type:) public func sfmc_handle(_ url: URL, type: String) {
        if UIApplication.shared.canOpenURL(url) == true {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    if success {
                        print("url \(url) opened successfully")
                    } else {
                        print("url \(url) could not be opened")
                    }
                })
            } else {
                if UIApplication.shared.openURL(url) == true {
                    print("url \(url) opened successfully")
                } else {
                    print("url \(url) could not be opened")
                }
            }
        }
    }
    
    /*
     * IN-APP Messaging
     */
    public func sfmc_didShow(inAppMessage message: [AnyHashable : Any]) {
        // message shown
    }
    
    public func sfmc_didClose(inAppMessage message: [AnyHashable : Any]) {
        // message closed
    }
}


