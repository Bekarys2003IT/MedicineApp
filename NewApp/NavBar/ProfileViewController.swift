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
        textField.placeholder = "Enter your full name"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var diagnoseProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Diagnose of doctor"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var heightProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your height"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var weightProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your weight"
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var dietProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Diet"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var schemeProfileTextField:UITextField = {
       let textField = UITextField()
        textField.placeholder = "Scheme of taking pills"
        textField.layer.cornerRadius = 8
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
        view.addSubview(diagnoseProfileTextField)
        view.addSubview(heightProfileTextField)
        view.addSubview(weightProfileTextField)
        view.addSubview(dietProfileTextField)
        view.addSubview(schemeProfileTextField)
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
        diagnoseProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(nameProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        heightProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(diagnoseProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        weightProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(heightProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        dietProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(weightProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        schemeProfileTextField.snp.makeConstraints { make in
            make.top.equalTo(dietProfileTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        profileSaveButton.snp.makeConstraints { make in
            make.top.equalTo(schemeProfileTextField.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    @objc func profileSave(){
        print("profile Tapped")
        
        if (nameProfileTextField.text?.isEmpty ?? true) || (diagnoseProfileTextField.text?.isEmpty ?? true) || (heightProfileTextField.text?.isEmpty ?? true) || (weightProfileTextField.text?.isEmpty ?? true) || (dietProfileTextField.text?.isEmpty ?? true) || (schemeProfileTextField.text?.isEmpty ?? true) {
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
                profileDiagnose: diagnoseProfileTextField.text ?? "",
                profileHeight: heightProfileTextField.text ?? "",
                profileWeight: weightProfileTextField.text ?? "",
                profileDiet: dietProfileTextField.text ?? "",
                profileScheme: schemeProfileTextField.text ?? ""
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
                self?.diagnoseProfileTextField.text = profile.profileDiagnose
                self?.heightProfileTextField.text = profile.profileHeight
                self?.weightProfileTextField.text = profile.profileWeight
                self?.dietProfileTextField.text = profile.profileDiet
                self?.schemeProfileTextField.text = profile.profileScheme
            }
        }
    }
}
    
