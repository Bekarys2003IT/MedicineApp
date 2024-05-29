//
//  DrugsViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 01.05.2024.
//

import UIKit

class DrugsViewController: UIViewController {
    var selectedDrug: InfoDrug?
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22,weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var descriptionLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       setUI()
    }
    
    private func setUI(){
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)

               nameLabel.snp.makeConstraints { make in
                   make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                   make.centerX.equalToSuperview()
               }

               descriptionLabel.snp.makeConstraints { make in
                   make.top.equalTo(nameLabel.snp.bottom).offset(20)
                   make.left.right.equalTo(view.layoutMarginsGuide)
               }

               nameLabel.text = selectedDrug?.name
               descriptionLabel.text = selectedDrug?.descrip
    }
    
    

}
