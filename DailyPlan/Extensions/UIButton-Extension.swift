//
//  UIButton-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/22.
//

import UIKit

extension UIButton {
    
    func createClearButton(action: @escaping () -> Void) -> UIButton {
        self.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15)), for: .normal)
        self.tintColor = .systemGray4
        self.addAction(UIAction { _ in
            action()
        }, for: .primaryActionTriggered)
        return self
    }
    
    func createSimpleButton(title: String, action: @escaping () -> Void) -> UIButton {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.systemGray5, for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 5
        self.addAction(UIAction { _ in
            action()
        }, for: .primaryActionTriggered)
        return self
    }
    
}
