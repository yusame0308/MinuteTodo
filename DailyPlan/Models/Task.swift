//
//  Task.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/09.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title = ""
    @objc dynamic var length = 0
    @objc dynamic var limit = Date()
    @objc dynamic var isDone = false
}
