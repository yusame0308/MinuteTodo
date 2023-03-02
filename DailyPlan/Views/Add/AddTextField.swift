//
//  AddTextField.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/13.
//

import UIKit

class AddTextField: UITextField {
    
    init(placeHolder: String, type: UIKeyboardType = .default, fontSize: CGFloat = 18) {
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 5
        font = .systemFont(ofSize: fontSize)
        keyboardType = type
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        return false
    }
    
}
