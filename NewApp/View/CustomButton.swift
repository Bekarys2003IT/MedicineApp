//
//  CustomButton.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 18.04.2024.
//

import UIKit

class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title:String,hasBackgorund: Bool = false, fontSize:FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackgorund ? .systemBlue : .clear
        
        let titleColor:UIColor = hasBackgorund ? .white : .systemBlue
        self.setTitleColor(titleColor, for: .normal)
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
