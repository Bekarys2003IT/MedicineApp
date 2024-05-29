//
//  PermissionService.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 20.05.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class PermissionService {
    static let shared = PermissionService()

    private let db = Firestore.firestore()
    
    var currentUserEmail: String? {
          return Auth.auth().currentUser?.email
      }

    func grantPermission(request: PermissionRequest, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "ownerEmail": request.ownerEmail,
            "viewerEmail": request.viewerEmail,
            "canViewDetails": request.canViewDetails
        ]
        db.collection("permissions").addDocument(data: data, completion: completion)
    }

    func revokePermission(request: PermissionRequest, completion: @escaping (Error?) -> Void) {
        let query = db.collection("permissions")
            .whereField("ownerEmail", isEqualTo: request.ownerEmail)
            .whereField("viewerEmail", isEqualTo: request.viewerEmail)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                completion(error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            for document in documents {
                document.reference.delete(completion: completion)
            }
        }
    }

    func canViewDetails(ownerEmail: String, viewerEmail: String, completion: @escaping (Bool) -> Void) {
            let query = db.collection("permissions")
                .whereField("ownerEmail", isEqualTo: ownerEmail)
                .whereField("viewerEmail", isEqualTo: viewerEmail)
                .whereField("canViewDetails", isEqualTo: true)
            
            query.getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                completion(snapshot?.documents.count ?? 0 > 0)
            }
        }
    func fetchMedicines(ownerEmail: String, completion: @escaping (Result<[FirebaseMedicine], Error>) -> Void) {
            let query = db.collection("medicines").whereField("ownerEmail", isEqualTo: ownerEmail)
            query.getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                let medicines = snapshot?.documents.compactMap { document in
                    return FirebaseMedicine.fromDictionary(document.data())
                } ?? []
                completion(.success(medicines))
            }
        }
}
