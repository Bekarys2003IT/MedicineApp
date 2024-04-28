//
//  ProfileModel.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 27.04.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
class ProfileService {
    public static let shared = ProfileService()
    private init() {}
    
    func saveProfileData(with profile:ProfileUserRequest,uid:String, completion: @escaping (Error?) -> Void){
        let db = Firestore.firestore()
        db.collection("profiles").document(uid).setData(profile.dictionary) { error in
            completion(error)
        }
    }
    func fetchProfileData(uid: String, completion: @escaping (ProfileUserRequest?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("profiles").document(uid).getDocument { (document, error) in
            guard let document = document, document.exists else {
                completion(nil, error)
                return
            }
            let data = document.data()
            let profile = ProfileUserRequest(
                profileName: data?["profileName"] as? String ?? "",
                profileLastName: data?["profileLastName"] as? String ?? "",
                profileEmail: data?["profileEmail"] as? String ?? "",
                profilePhone: data?["profilePhone"] as? String ?? ""
            )
            completion(profile, nil)
        }
    }

}

