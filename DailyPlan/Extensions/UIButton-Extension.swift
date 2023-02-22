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
        self.tintColor = .systemGray3
        self.addAction(UIAction { _ in
            action()
        }, for: .primaryActionTriggered)
        return self
    }
    
}
