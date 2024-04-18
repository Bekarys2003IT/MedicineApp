//
//  AlertManager.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 18.04.2024.
//

import Foundation
import UIKit
class AlertManager {
    private static func showBasicAlert(on vc: UIViewController,  title:String,  message:String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

//MARK: Show validation alerts
extension AlertManager {
    public static func showInvalidEmailAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Invalid email",  message: "Please enter a valid email")
    }
    public static func showInvalidPasswordAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Invalid password",  message: "Please enter correct password")
    }
    public static func showInvalidUserNameAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Invalid username",  message: "Please enter a valid Username")
    }
}
//MARK: Show registration alerts
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Unknown Registration error",  message: nil)
    }
    public static func showRegistrationErrorAlert(on vc:UIViewController, with error:Error){
        self.showBasicAlert(on: vc,  title: "Unknown Registration error",  message: "\(error.localizedDescription)")
    }
}
//MARK: Show login errors
extension AlertManager {
    public static func showSignInErrorAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Unknown Signing in error",  message: nil)
    }
    public static func showSigninErrorAlert(on vc:UIViewController, with error:Error){
        self.showBasicAlert(on: vc,  title: "Unknown Signing in error",  message: "\(error.localizedDescription)")
    }
}
//MARK: Logout errors
extension AlertManager {
    public static func showLogoutError(on vc:UIViewController, with error:Error){
        self.showBasicAlert(on: vc,  title: "Log out Error",  message: "\(error.localizedDescription)")
    }
}
//MARK: Forgot password errors
extension AlertManager {
    
    public static func showPasswordResetSent(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Password Reset sent",  message: nil)
    }
    public static func showErrorSendingPasswordReset(on vc:UIViewController, with error:Error){
        self.showBasicAlert(on: vc,  title: "Error sending password reset",  message: "\(error.localizedDescription)")
    }
}
//MARK: Fetching user errors
extension AlertManager {
    
    public static func showFetchingUserError(on vc:UIViewController , with error: Error){
        self.showBasicAlert(on: vc,  title: "Error fetching user",  message: "\(error.localizedDescription)")
    }
    public static func showUnknownFetchingUserError(on vc:UIViewController){
        self.showBasicAlert(on: vc,  title: "Unknown Error fetching user",  message: nil)
    }
}
