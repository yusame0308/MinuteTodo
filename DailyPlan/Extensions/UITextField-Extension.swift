//
//  UITextField-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/23.
//

import UIKit

extension UITextField {
    
    var isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }
    
    func validateWithMaxLength(_ length: Int) {
        guard let text = self.text else { return }
        
        if text.count > length {
            self.text = text.prefix(length).description
        }
    }
    
}
