//
//  LimitTextField.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/19.
//

import UIKit

class LimitTextField: AddTextField {
    
    let formatter = DateFormatter()
    
    let limitDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .white
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ja_JP")
        picker.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return picker
    }()
    
    var selectedDate: Date {
        get {
            return limitDatePicker.date
        }
        set(date) {
            limitDatePicker.date = date
            updateTextField(newDate: date)
        }
    }

    init(action: @escaping () -> Void) {
        super.init(placeHolder: "期限", fontSize: 15)
        
        inputView = limitDatePicker
        inputAccessoryView = LimitToolBar(doneAction: doneDatePickerAction, cancelAction: cancelDatePickerAction, action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func doneDatePickerAction() {
        updateTextField(newDate: selectedDate)
        endEditing(true)
    }
    
    private func cancelDatePickerAction() {
        endEditing(true)
    }
    
    private func updateTextField(newDate: Date) {
        formatter.dateFormat = "M月d日(EEE)"
        self.text = formatter.string(from: newDate)
    }
}
