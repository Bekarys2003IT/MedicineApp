//
//  ProfileUserRequest.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 27.04.2024.
//

import Foundation
struct ProfileUserRequest {
    let profileName:String
    let profileLastName:String
    let profileEmail:String
    let profilePhone:String
    
    var dictionary: [String: Any] {
           return [
               "profileName": profileName,
               "profileLastName": profileLastName,
               "profileEmail": profileEmail,
               "profilePhone": profilePhone
           ]
       }
}
