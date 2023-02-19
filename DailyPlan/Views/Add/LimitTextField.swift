//
//  LimitTextField.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/19.
//

import UIKit

class LimitTextField: AddTextField {
    
    let limitDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .white
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ja_JP")
        picker.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return picker
    }()

    init() {
        super.init(placeHolder: "期限", fontSize: 15)
        
        inputView = limitDatePicker
        inputAccessoryView = LimitToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
