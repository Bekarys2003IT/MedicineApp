//
//  AboutAppViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import RealmSwift
import SnapKit
class AboutAppViewController: UIViewController {
    
    private let namelabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Домашняя аптечка"
        label.numberOfLines = 2
        return label
    }()
    private lazy var someView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.layer.borderColor = .init(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        view.layer.borderWidth = 2
        return view
    }()
    private lazy var infoLabel:UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "В настоящее время большинство людей используют мобильные приложения, с их помощью сильно упрощается жизнь. Приложение Домашняя аптечка позволяет вести учет всех лекарств, хранящихся дома, их срока годности. Напоминания о приёме, настройки для всех членов семьи. Возможность использования категорий лекарств, просмотра истории приёма. Благодаря этому приложению, пользователю легче отслеживать прием своих лекарств, управлять и хранить данные о сових медицинских препаратах, также следить за информацией о своих медицинских заболеваниях и симптомах"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchUsers()
        logout()
    }
    private func setupUI(){
        view.addSubview(namelabel)
        view.addSubview(someView)
        someView.addSubview(infoLabel)
        
        //constraint
        namelabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
        someView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(500)
            
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
extension AboutAppViewController {
    private func logout(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    @objc private func didTapLogout(){
        print("Tapped")
        Authservice.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.checkAuthentication()
            }
        }
    }
    func fetchUsers() {
        Authservice.shared.fetchUser { [weak self] user , error in
            guard let self = self else {return}
            if let error = error{
                AlertManager.showFetchingUserError(on: self, with: error)
            }
            if let user = user {
                self.namelabel.text = "\(user.userName)\n\(user.email)"
            }
        }
    }
}
