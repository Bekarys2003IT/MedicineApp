//
//  Validator.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 21.04.2024.
//

import Foundation
import FirebaseAuth

class Validator {
    static func isValidEmail(for email:String) -> Bool{
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    static func isValidUserName(userName:String) -> Bool {
        let userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let userNameRegex = "\\w{4,24}"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        return userNamePred.evaluate(with: userName)
    }
    static func isPasswordValid(for password:String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%ˆ&*+-=_<>]).{6,15}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
}
