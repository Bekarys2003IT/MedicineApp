//
//  PillsTableViewCell.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 14.04.2024.
//

import UIKit

class PillsTableViewCell: UITableViewCell {
 
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 16,weight: .heavy)
        return label
    }()
    lazy var iconView:UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "pills.circle")
        icon.tintColor = .red
        return icon
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    private func setUI(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconView)
        
        //constraint
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
