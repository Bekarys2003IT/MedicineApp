//
//  InfoDrug.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 01.05.2024.
//

import Foundation
import RealmSwift

class InfoDrug: Object {
   @Persisted var name: String
   @Persisted var descrip: String
    
    convenience init(name: String, descrip: String) {
           self.init()
           self.name = name
           self.descrip = descrip
       }
}
