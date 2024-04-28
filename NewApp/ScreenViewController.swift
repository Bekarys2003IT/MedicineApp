//
//  ScreenViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 20.04.2024.
//

import UIKit
import SnapKit
class ScreenViewController: UIViewController {

    private lazy var iconImageView:UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "iconImage")
        return image
    }()
    private lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Medicine app"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    private  func setUI(){
        view.addSubview(iconImageView)
        view.addSubview(label)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(250)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(40)
        }
    }
    

    

}
