//
//  SwipeButton.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/26.
//

import UIKit

class SwipeButton: UIButton {
    
    init(imageName: String, color: UIColor, isAtEnd: Bool = false) {
        super.init(frame: .zero)
        
        setImage(UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        tintColor = .white
        backgroundColor = color.withAlphaComponent(0.4)
        layer.cornerRadius = isAtEnd ? 4 : 0
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
