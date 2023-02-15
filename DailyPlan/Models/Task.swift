//
//  Task.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/09.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var title: String
    @Persisted var length: Int?
    @Persisted var limit: Date?
    @Persisted var isDone = false
}
