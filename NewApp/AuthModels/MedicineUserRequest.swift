//
//  MedicineUserRequest.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 06.05.2024.
//

import Foundation
struct MedicineUserRequest:Codable {
    var type:String
    var medicament: String
    var pills: Array<Pills>
    struct Pills:Codable {
        var name: String
        var expireDate: Date = Date()
        var purchasePrice: String
        var notice: String
        var iconName: String
        var illName:String
    }
    
}

