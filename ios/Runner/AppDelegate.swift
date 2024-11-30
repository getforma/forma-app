import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
      let api = SensorApiImplementation(binaryMessenger: controller.binaryMessenger)
    SensorApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: api)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
