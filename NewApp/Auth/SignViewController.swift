//
//  SignViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import SnapKit

class SignViewController: UIViewController {
    
   
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 60, weight: .bold)
        return label
    }()
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    private let emailTextField = CustomTextField(fieldType: .email)
    private let passwordTextField = CustomTextField(fieldType: .password)
    private let signButton = CustomButton(title: "Sign in",hasBackgorund: true ,fontSize: .big)
    private let createAccountButton = CustomButton(title: "Create account",hasBackgorund: false, fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot your password?",hasBackgorund: false ,fontSize: .small)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        AlertManager.showInvalidEmailAlert(on: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        addTargets()
    }
    private func setUI(){
        view.addSubview(loginLabel)
        self.view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        self.view.addSubview(headerView)
        view.addSubview(forgotPasswordButton)
        view.addSubview(createAccountButton)
        view.addSubview(signButton)
        
        //constraint
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)

        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
       
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(createAccountButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    private func addTargets(){
        self.signButton.addTarget(self, action: #selector(signTap), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(forgotTap), for: .touchUpInside)
        self.createAccountButton.addTarget(self, action: #selector(createTap), for: .touchUpInside)
    }
    @objc func signTap(){
        print("Tapped")
        let loginRequest = LoginUserRequest.init(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? "")
       
        if !Validator.isValidEmail(for: loginRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
    }
        if !Validator.isPasswordValid(for: loginRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            return
    }
        //Auth check
        Authservice.shared.signIn(with: loginRequest) { error in
                if let error = error {
                    AlertManager.showSigninErrorAlert(on: self, with: error)
                    return
                }
                // Assuming a successful login will update the current user
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.checkAuthentication()
                }
            }
        

    }
    @objc func forgotTap(){
        print("forgotTapped")
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }

    @objc func createTap(){
        print("createTapped")
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    


}
