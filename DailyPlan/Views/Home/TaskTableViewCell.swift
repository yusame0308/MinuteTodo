//
//  TaskTableViewCell.swift
//  DailyPlan
//
//  Created by 小原宙 on 2022/11/03.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let limitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(limitLabel)
        
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, topPadding: 10, leftPadding: 30)
        timeLabel.anchor(top: titleLabel.bottomAnchor, bottom: self.bottomAnchor, left: titleLabel.leftAnchor, bottomPadding: 10)
        limitLabel.anchor(left: titleLabel.rightAnchor, right: self.rightAnchor, centerY: self.centerYAnchor, width: 50, leftPadding: 10, rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(title: String, time: Int, limit: String) {
        titleLabel.text = title
        timeLabel.text = String(time)
        limitLabel.text = limit
    }
    
}
