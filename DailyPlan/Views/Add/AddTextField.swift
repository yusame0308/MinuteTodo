//
//  AddTextField.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/13.
//

import UIKit

class AddTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 5
        font = .systemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
