//
//  AboutAppViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import RealmSwift
class AboutAppViewController: UIViewController {
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "...Loading"
        label.numberOfLines = 2
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        logout()
    }
    private func setupUI(){
        view.addSubview(label)
        
        //constraint
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension AboutAppViewController {
    private func logout(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    @objc private func didTapLogout(){
        
    }
}
