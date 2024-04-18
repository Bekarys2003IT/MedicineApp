//
//  AuthHeaderView.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 18.04.2024.
//

import UIKit

class AuthHeaderView: UIView {

    private let titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26,weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.text = "Error"
        return label
    }()
    
    //MARK:Lifecycle
    init(title:String,subTitle:String){
        super.init(frame:.zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        // constraint
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
    }
}
