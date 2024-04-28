//
//  ForgotPasswordViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 18.04.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailTextField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset password", hasBackgorund: true, fontSize: .big)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        addTarget()
    }
    private func setupUI(){
        view.addSubview(headerView)
        view.addSubview(emailTextField)
        view.addSubview(resetPasswordButton)
        
        //constraint
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)

        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(280)
        }
        
    }
    private func addTarget(){
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    @objc func didTapForgotPassword(){
        print("didtapforgot tapped")
        let email = self.emailTextField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        Authservice.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else {return}
            if let error = error{
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            AlertManager.showPasswordResetSent(on: self)
        }
    }

    

}
