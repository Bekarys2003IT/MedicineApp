//
//  Medicine.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 14.04.2024.
//

import Foundation
import RealmSwift
class Medicine:Object {
    @Persisted var id = UUID().uuidString
    @Persisted var type: String
    @Persisted var medicament: String
    @Persisted var iconName: String
    @Persisted var pills: List<Pill> 
}
