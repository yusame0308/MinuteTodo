//
//  Date-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/27.
//

import Foundation

extension Date {
    
    func toLongStringWithCurrentLocale() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "M月d日(EEE)"
        
        return formatter.string(from: self)
    }
    
    func toShortStringWithCurrentLocale() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "M/d"
        
        return formatter.string(from: self)
    }
    
}
