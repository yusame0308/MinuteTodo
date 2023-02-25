//
//  HorizontalPanGestureRecognizer.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/24.
//

import UIKit

class HorizontalPanGestureRecognizer: UIPanGestureRecognizer, UIGestureRecognizerDelegate {

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        delegate = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }

    // 水平方向のみ有効にする
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let pan = gestureRecognizer as! UIPanGestureRecognizer
        let trans = pan.translation(in: gestureRecognizer.view)
        return abs(trans.x) > abs(trans.y)
    }
    
}
