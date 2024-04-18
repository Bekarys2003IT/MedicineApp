//
//  MedicineTableViewCell.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import SnapKit
class MedicineTableViewCell: UITableViewCell {
    var clickButtonAction: (() -> Void)?
    lazy var typeLabel:UILabel = {
       let label = UILabel()
        label.text = "Домашняя аптечка"
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    lazy var medicamentLabel:UILabel = {
       let label = UILabel()
        label.text = "Медикаменты: "
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    lazy var iconView:UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "cross.case.fill")
        icon.tintColor = .red
        return icon
    }()
    lazy var clickButton:UIButton = {
       let click = UIButton()
        click.setTitle("Откликнуться", for: .normal)
        click.setTitleColor(.white, for: .normal)
        click.titleLabel?.font = .systemFont(ofSize: 12)
        click.backgroundColor = UIColor(red: 102/255, green: 178/255, blue: 76/255, alpha: 1)
        click.addTarget(self, action: #selector(clickButtonTapped), for: .touchUpInside)
        click.layer.cornerRadius = 16
        return click
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    private func setUI(){
        contentView.addSubview(typeLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(medicamentLabel)
        
        
        //constraint
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        iconView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(5);            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        medicamentLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(20)
            make.leading.equalTo(iconView.snp.trailing).offset(20)
        }
        
    }
    @objc func clickButtonTapped(){
        print("CLick is tapped")
        clickButtonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
