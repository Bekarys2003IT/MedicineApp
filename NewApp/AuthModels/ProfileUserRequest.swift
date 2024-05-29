//
//  ProfileUserRequest.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 27.04.2024.
//

import Foundation
struct ProfileUserRequest {
    let profileName:String
    let profileDiagnose:String
    let profileHeight:String
    let profileWeight:String
    let profileDiet:String
    let profileScheme:String
    
    var dictionary: [String: Any] {
           return [
               "profileName": profileName,
               "profileDiagnose": profileDiagnose,
               "profileHeight": profileHeight,
               "profileWeight": profileWeight,
               "profileDiet": profileDiet,
               "profileScheme": profileScheme
           ]
       }
}
