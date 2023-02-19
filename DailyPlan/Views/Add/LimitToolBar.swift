//
//  LimitToolBar.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/19.
//

import UIKit

class LimitToolBar: UIToolbar {
    
    let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("完了", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addAction(UIAction { [self] _ in
        }, for: .primaryActionTriggered)
        return UIBarButtonItem(customView: button)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setItems([spaceItem,doneItem], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
