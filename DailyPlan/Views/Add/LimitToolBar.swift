//
//  LimitToolBar.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/19.
//

import UIKit

class LimitToolBar: UIToolbar {
    
    let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    let doneItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("完了", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    init(action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        let button = doneItem.customView as! UIButton
        button.addAction(UIAction { _ in
            action()
        }, for: .primaryActionTriggered)
        
        fixedSpaceItem.width = 20
        self.setItems([flexibleSpaceItem, doneItem, fixedSpaceItem], animated: true)
        self.barTintColor = .white
        self.anchor(height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
