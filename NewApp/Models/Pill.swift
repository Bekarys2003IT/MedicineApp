//
//  Pill.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 17.04.2024.
//

import Foundation
import RealmSwift
class Pill: Object {
    @Persisted var name: String = ""
    @Persisted var expireDate: Date = Date()
    @Persisted var purchasePrice: String = ""
    @Persisted var notice: String = ""
    @Persisted var iconName: String = ""
}
