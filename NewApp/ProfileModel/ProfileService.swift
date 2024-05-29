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
                profileDiagnose: data?["profileDiagnose"] as? String ?? "",
                profileHeight: data?["profileHeight"] as? String ?? "",
                profileWeight: data?["profileWeight"] as? String ?? "",
                profileDiet: data?["profileDiet"] as? String ?? "",
                profileScheme: data?["profileScheme"] as? String ?? ""
            )
            completion(profile, nil)
        }
    }

}

