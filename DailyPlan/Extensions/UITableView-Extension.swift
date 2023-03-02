//
//  UITableView-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/03/02.
//

import UIKit

extension UITableView {
    
    func closeAllCellsSwipeButton() {
        for c in self.visibleCells {
            let cell = c as! TaskTableViewCell
            if cell.showsSwipeButtons {
                cell.showsSwipeButtons = false
            }
        }
    }
    
}
