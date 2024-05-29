





import Foundation
import Firebase
import FirebaseFirestore
import FirebaseCore

class MedicineService {
    public static let shared = MedicineService()
    private init() {}

    // Function to save `MedicineUserRequest` to Firestore
//    func saveMedicineData(with saveMedicine: MedicineUserRequest, uid: String, completion: @escaping (Error?) -> Void) {
//        let db = Firestore.firestore()
//        do {
//            // Encode `MedicineUserRequest` to JSON data
//            let jsonData = try JSONEncoder().encode(saveMedicine)
//            
//            // Convert JSON data to a dictionary for Firestore
//            guard let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
//                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"]))
//                return
//            }
//
//            // Save the dictionary to Firestore using the specified UID
//            db.collection("medicines").document(uid).setData(dictionary) { error in
//                completion(error)
//            }
//        } catch {
//            // Handle errors in the encoding or serialization process
//            completion(error)
//        }
//    }
    func saveMedicineData(medicine: FirebaseMedicine, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let dictionary = medicine.toDictionary()
        db.collection("medicines").document(medicine.id).setData(dictionary) { error in
            completion(error)
        }
    }
    func updateMedicineWithPills(medicine: FirebaseMedicine, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let dictionary = medicine.toDictionary()
        db.collection("medicines").document(medicine.id).updateData(["pills": medicine.pills.map { $0.toDictionary() }]) { error in
            completion(error)
        }
    }


    // Function to fetch `MedicineUserRequest` data from Firestore
    func fetchMedicineData(uid: String, completion: @escaping (MedicineUserRequest?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("medicines").document(uid).getDocument { (document, error) in
            guard let document = document, document.exists else {
                completion(nil, error)
                return
            }

            // Retrieve data from the Firestore document
            guard let data = document.data() else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch document data"]))
                return
            }

            do {
                // Convert data back to JSON
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                
                // Decode JSON to a `MedicineUserRequest` object
                let medicine = try JSONDecoder().decode(MedicineUserRequest.self, from: jsonData)
                completion(medicine, nil)
            } catch {
                // Handle errors in the decoding or conversion process
                completion(nil, error)
            }
        }
    }
    func deleteMedicineData(uid: String, completion: @escaping (Error?) -> Void) {
           let db = Firestore.firestore()
           db.collection("medicines").document(uid).delete { error in
               completion(error)
           }
       }
    
}
