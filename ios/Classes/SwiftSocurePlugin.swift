import Flutter
import UIKit
import SocureDocV

public class SwiftSocurePlugin: NSObject, FlutterPlugin {
    let objDocVHelper = SocureDocVHelper()
    var controller: UIViewController
    let callResult = { (result: @escaping FlutterResult, data: Any) in
        result(data)
    }

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

        var resultHandler: ((Result<ScannedData, ScanError>) -> Void) {
            {
                switch $0 {
                case .success(let data):
                    let responseData = data.dictionary.convertToStr()
                    result(responseData)
                    break;
                    // self.controller.showToast(message: "SUCCESS RESULTS \(result.dictionary)", font: .systemFont(ofSize: 12.0))
                case .failure(let error):
                    let responseError = error.dictionary.convertToStr()
                    result(responseError)
                    break;
                    // self.controller.showToast(message: "ERROR RESULTS \(responseError)", font: .systemFont(ofSize: 12.0))
                }
            }
        }
        let arguments = call.arguments as! Dictionary<String, Any>
        switch call.method {
        case "launchSocure":
            let socureSdkKey: String = arguments["sdkKey"] as! String
            var flowConfig: [String: Any]?
            do {
                flowConfig = try (arguments["flow"] as? String)?.convertToDictionary()
            } catch {
                 let errorDict = ["errorMessage": "Invalid config data", "statusCode": "7109"]
                 let responseError = errorDict.convertToStr()
                 result(responseError)
                return
            }
            //controller.showToast(message: "Hey it has reached here", font: .systemFont(ofSize: 12.0))
            objDocVHelper.launch(
                    socureSdkKey,
                    presentingViewController: controller,
                    config: flowConfig,
                    completionBlock: resultHandler
            )
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

extension Dictionary {
    func convertToStr() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)
            return jsonString
        } catch {
            return nil
        }
    }
}

//extension Result<ScannedData, ScanError> {

//    func getItem() -> dictionary<String, Any> {
//        switch self {
//        case .success:
//            return DisplaySingle(banner: banner)
//        case .failure:
//            return DisplaySlider(banner: banner)
//        }
//    }
//}


extension UIViewController {

    func showToast(message: String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 75, y: self.view.frame.size.height - 100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


// extension Result {

//     func get() throws -> Value {
//         switch self {
//         case .success(let value):
//             return value
//         case .failure(let error):
//             throw error
//         }
//     }
// }


