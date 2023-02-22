//
//  UIBarButtonItem-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/22.
//

import UIKit

extension UIBarButtonItem {
    
    func createToolBarButtonItem(title: String) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        self.customView = button
        return self
    }
    
}
