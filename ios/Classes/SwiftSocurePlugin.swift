import Flutter
import UIKit
import SocureDocV

public class SwiftSocurePlugin: NSObject, FlutterPlugin {
  let objDocVHelper = SocureDocVHelper()
  var controller : UIViewController

  init(uiViewController: UIViewController) {
          controller = uiViewController
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "socure", binaryMessenger: registrar.messenger())
    let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
    let instance = SwiftSocurePlugin(uiViewController: viewController)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    let arguments = call.arguments as? Dictionary<String, Any>
    switch call.method {
        case "launchSocure":
//            var flowConfig: [String : Any]? = arguments["flow"]
           let socureSdkKey: String = arguments["sdkKey"]!
           var flowConfig: [String: Any]?
                 do {
                     flowConfig = try arguments["flow"]?.convertToDictionary()
                 } catch {
                     let errorDict = ["errorMessage": "Invalid config data", "statusCode": "7109"]
                     result([errorDict])
                     return
                 }
           objDocVHelper.launch(socureSdkKey, presentingViewController: controller, config: flowConfig, completionBlock: { result in
              switch result {
              case .success(let scan):
                  print(scan)
                  result([scan.dictionary])
                  break
              case .failure(let error):
                  print(error)
                  result([error.dictionary])
                  break
              }
          })
            return
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            return
        default:
            result(FlutterMethodNotImplemented)
            return
    }
  }
}

extension String {
    func convertToDictionary() throws -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                throw error
            }
        }
        return nil
    }
}
