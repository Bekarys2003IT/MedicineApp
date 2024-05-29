//
//  FirebaseModel.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.05.2024.
//

import Foundation
import UIKit

class FirebasePill {
    var name: String
    var expireDate: Date
    var purchasePrice: String
    var notice: String
    var iconName: String
    var illName: String

    init(name: String, expireDate: Date, purchasePrice: String, notice: String, iconName: String, illName: String) {
        self.name = name
        self.expireDate = expireDate
        self.purchasePrice = purchasePrice
        self.notice = notice
        self.iconName = iconName
        self.illName = illName
    }

    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "expireDate": expireDate,
            "purchasePrice": purchasePrice,
            "notice": notice,
            "iconName": iconName,
            "illName": illName
        ]
    }

    static func fromDictionary(_ dictionary: [String: Any]) -> FirebasePill? {
        guard let name = dictionary["name"] as? String,
              let expireDate = dictionary["expireDate"] as? Date,
              let purchasePrice = dictionary["purchasePrice"] as? String,
              let notice = dictionary["notice"] as? String,
              let iconName = dictionary["iconName"] as? String,
              let illName = dictionary["illName"] as? String else {
            return nil
        }
        return FirebasePill(name: name, expireDate: expireDate, purchasePrice: purchasePrice, notice: notice, iconName: iconName, illName: illName)
    }
}

class FirebaseMedicine {
    var id: String
    var type: String
    var medicament: String
    var iconName: String
    var pills: [FirebasePill]

    init(id: String = UUID().uuidString, type: String, medicament: String, iconName: String, pills: [FirebasePill]) {
        self.id = id
        self.type = type
        self.medicament = medicament
        self.iconName = iconName
        self.pills = pills
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "type": type,
            "medicament": medicament,
            "iconName": iconName,
            "pills": pills.map { $0.toDictionary() }
        ]
    }

    static func fromDictionary(_ dictionary: [String: Any]) -> FirebaseMedicine? {
        guard let id = dictionary["id"] as? String,
              let type = dictionary["type"] as? String,
              let medicament = dictionary["medicament"] as? String,
              let iconName = dictionary["iconName"] as? String,
              let pillsDictionaries = dictionary["pills"] as? [[String: Any]] else {
            return nil
        }
        let pills = pillsDictionaries.compactMap { FirebasePill.fromDictionary($0) }
        return FirebaseMedicine(id: id, type: type, medicament: medicament, iconName: iconName, pills: pills)
    }
}

