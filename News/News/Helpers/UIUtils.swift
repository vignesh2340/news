//
//  UIUtils.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

class UIUtils: NSObject {
    static func showDefaultAlertView(withTitle title: String?, message: String?) {
        let rootViewController = UIApplication().keyWindow?.rootViewController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        rootViewController?.present(alertController, animated: true)
    }
}
extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
