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
    let cancelItem = UIBarButtonItem().createToolBarButtonItem(title: "キャンセル")
    let doneItem = UIBarButtonItem().createToolBarButtonItem(title: "完了")
    
    init(doneAction: @escaping () -> Void, cancelAction: @escaping () -> Void, action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        let doneButton = doneItem.customView as! UIButton
        doneButton.addAction(UIAction { _ in
            doneAction()
            action()
        }, for: .primaryActionTriggered)
        
        let cancelButton = cancelItem.customView as! UIButton
        cancelButton.addAction(UIAction { _ in
            cancelAction()
        }, for: .primaryActionTriggered)
        
        fixedSpaceItem.width = 20
        self.setItems([fixedSpaceItem, cancelItem, flexibleSpaceItem, doneItem, fixedSpaceItem], animated: true)
        self.barTintColor = .white
        self.anchor(height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
