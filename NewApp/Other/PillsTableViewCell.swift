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
    lazy var expireDateLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .medium)
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    private func setUI(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(expireDateLabel)
        
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
        expireDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
       
    }
    func configure(with pill: Pill) {
        nameLabel.text = pill.name
        expireDateLabel.text = "Срок годности: \(formatDate(pill.expireDate))"
    }
           
        func formatDate(_ date: Date) -> String {
               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .medium
               dateFormatter.timeStyle = .none
               return dateFormatter.string(from: date)
           }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
