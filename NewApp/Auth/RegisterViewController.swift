//
//  RegisterViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 18.04.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    lazy var registerLabel:UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 60, weight: .bold)
        return label
    }()

    private let headerView = AuthHeaderView(title: "Create account", subTitle: "Create your new account")
    private let userNameField = CustomTextField(fieldType: .username)
    private let emailTextField = CustomTextField(fieldType: .email)
    private let passwordTextField = CustomTextField(fieldType: .password)
    private let signUpButton = CustomButton(title: "Sign up",hasBackgorund: true ,fontSize: .big)
    private let alreadyButton = CustomButton(title: "Already have an account? Sign in",hasBackgorund: false, fontSize: .med)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        addTarget()
    }
    private func setUI(){
        view.addSubview(registerLabel)
        view.addSubview(headerView)
        view.addSubview(userNameField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(alreadyButton)
        view.addSubview(signUpButton)
        
        //constraint
        
        registerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        userNameField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(280)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameField.snp.bottom).offset(30)
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
        alreadyButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(alreadyButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    private func addTarget(){
        self.alreadyButton.addTarget(self, action: #selector(alreadyTap), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(createTap), for: .touchUpInside)
        
    }
    @objc func alreadyTap(){
        print("already Tapped")
        navigationController?.pushViewController(SignViewController(), animated: true)
    }
    @objc func createTap(){
        print("register Tapped")

        let registerUserRequest = RegisterUserRequest(
            userName: self.userNameField.text ?? "",
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? "")
        //UserName check
        if !Validator.isValidUserName(userName: registerUserRequest.userName){
            AlertManager.showInvalidUserNameAlert(on: self)
            return
    }
        if !Validator.isValidEmail(for: registerUserRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
    }
        if !Validator.isPasswordValid(for: registerUserRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            return
    }
        Authservice.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if wasRegistered{
                if let appDelegate = self.view.window?.windowScene?.delegate as? AppDelegate{
                    appDelegate.checkAuthentication()
                }
                navigationController?.pushViewController(TabBarController(), animated: true)
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
        print(registerUserRequest)
        
        
   
    }
    


}
