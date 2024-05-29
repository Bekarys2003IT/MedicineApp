//
//  PermissionViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 20.05.2024.
//

import UIKit

class PermissionViewController: UIViewController {
    private let titleLabel:UILabel = {
       let label = UILabel()
        label.text = "Кто может видеть мои данные?"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    private let emailTextField:UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }()
    private let grantButton:UIButton = {
       let button = UIButton()
        button.setTitle("Grant Permission", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
    }()
    private let revokeButton:UIButton = {
       let button = UIButton()
        button.setTitle("Revoke Permission", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        addTargets()
    }
    
    private func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(grantButton)
        view.addSubview(revokeButton)
        
        //constraint
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        grantButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
        revokeButton.snp.makeConstraints { make in
            make.top.equalTo(grantButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
    private func addTargets() {
            grantButton.addTarget(self, action: #selector(grantTapped), for: .touchUpInside)
            revokeButton.addTarget(self, action: #selector(revokeTapped), for: .touchUpInside)
        }
        
        @objc private func grantTapped() {
            guard let email = emailTextField.text, !email.isEmpty else {
                // Show alert for empty email
                let alert = UIAlertController(title: "Error", message: "Fill email field!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }
            let request = PermissionRequest(ownerEmail: PermissionService.shared.currentUserEmail!, viewerEmail: email, canViewDetails: true)
            PermissionService.shared.grantPermission(request: request) { error in
                if let error = error {
                    // Show error alert
                    let alert = UIAlertController(title: "Error", message: "Permission request is denied", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                } else {
                    // Show success alert
                    let alert = UIAlertController(title: "Success", message: "You give a permission to \(self.emailTextField.text) !", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
        
        @objc private func revokeTapped() {
            guard let email = emailTextField.text, !email.isEmpty else {
                // Show alert for empty email
                let alert = UIAlertController(title: "Error", message: "Fill email field!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }
            let request = PermissionRequest(ownerEmail: PermissionService.shared.currentUserEmail!, viewerEmail: email, canViewDetails: true)
            PermissionService.shared.revokePermission(request: request) { error in
                if let error = error {
                    // Show error alert
                    let alert = UIAlertController(title: "Error", message: "Permission request is denied", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                } else {
                    // Show success alert
                    let alert = UIAlertController(title: "Success", message: "You revoke a permission from \(self.emailTextField.text) !", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }

}
