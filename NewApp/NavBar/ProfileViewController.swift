//
//  ProfileViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 27.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class ProfileViewController: UIViewController {

    private lazy var appNameLabel:UILabel = {
       let label = UILabel()
        label.text = "Аптечка"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        return label
    }()
    private lazy var nameProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var lastnameProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your lastname"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var emailProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var phoneProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your phone number"
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var profileSaveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(profileSave), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        loadProfileData()
    }
    private func setUI(){
        view.addSubview(appNameLabel)
        view.addSubview(nameProfileTextField)
        view.addSubview(lastnameProfileTextField)
        view.addSubview(emailProfileTextField)
        view.addSubview(phoneProfileTextField)
        view.addSubview(profileSaveButton)
        //constraint
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        nameProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(70)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        lastnameProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(nameProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        emailProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(lastnameProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        phoneProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(emailProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        profileSaveButton.snp.makeConstraints { make in
            make.top.equalTo(phoneProfileTextField.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    @objc func profileSave(){
        print("profile Tapped")
        
        if (nameProfileTextField.text?.isEmpty ?? true) || (lastnameProfileTextField.text?.isEmpty ?? true) || (emailProfileTextField.text?.isEmpty ?? true) || (phoneProfileTextField.text?.isEmpty ?? true) {
            let alert = UIAlertController(title: "Empty fields!", message:"Please fill in all the fields",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
        profileCreate()
    }
    

    

}
extension ProfileViewController {
    private func profileCreate(){
        guard let user = Auth.auth().currentUser else {
                print("No authenticated user found")
                return
            }

            let uid = user.uid  // Get the user's UID from Firebase Authentication
            let newProfile = ProfileUserRequest(
                profileName: nameProfileTextField.text ?? "",
                profileLastName: lastnameProfileTextField.text ?? "",
                profileEmail: emailProfileTextField.text ?? "",
                profilePhone: phoneProfileTextField.text ?? ""
            )

            // Pass the UID as an additional parameter to the saveProfileData method
            ProfileService.shared.saveProfileData(with: newProfile, uid: uid) { error in
                if let error = error {
                    print("Error saving profile: \(error)")
                    return
                }
                // Handle successful save, maybe navigate away or clear the form
                print("Profile saved successfully")
            }
    }
    private func loadProfileData() {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }
        ProfileService.shared.fetchProfileData(uid: user.uid) { [weak self] (profile, error) in
            guard let profile = profile else {
                print("Error fetching profile: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                self?.nameProfileTextField.text = profile.profileName
                self?.lastnameProfileTextField.text = profile.profileLastName
                self?.emailProfileTextField.text = profile.profileEmail
                self?.phoneProfileTextField.text = profile.profilePhone
            }
        }
    }
}
    
