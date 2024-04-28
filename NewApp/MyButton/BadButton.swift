//
//  BadButton.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 22.04.2024.
//

import Foundation
import UIKit
class BadButton: UIButton {
    var imageSize: CGSize?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // Your common initialization, if needed
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageViewSize = imageSize else {
            return
        }
        
        // Center the image
        if let imageView = self.imageView {
            imageView.frame = CGRect(x: (self.frame.width - imageViewSize.width) / 2, y: (self.frame.height - imageViewSize.height) / 2 - 10, width: imageViewSize.width, height: imageViewSize.height)
            imageView.contentMode = .scaleAspectFit
        }
        
        // Adjust the title label
        if let titleLabel = self.titleLabel {
            titleLabel.frame = CGRect(x: 0, y: self.imageView?.frame.maxY ?? 0 + 5, width: self.frame.width, height: titleLabel.frame.height)
            titleLabel.textAlignment = .center
        }
    }
    
    func setImageSize(_ size: CGSize) {
        imageSize = size
        self.setNeedsLayout()
    }
}
