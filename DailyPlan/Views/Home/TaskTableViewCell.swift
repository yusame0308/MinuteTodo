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
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    let checkmarkImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        iv.tintColor = .systemGray
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.hideShadow()
            }, completion: { _ in
                self.contentView.backgroundColor = .clear
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.addInnerShadow()
                    self.checkmarkImageView.tintColor = .systemGreen
                }, completion: nil)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.hideShadow()
            }, completion: { _ in
                self.contentView.backgroundColor = .white
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.addOuterShadow()
                    self.checkmarkImageView.tintColor = .systemGray
                }, completion: nil)
            })
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
    }
    
    private func setupLayout() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 4
        contentView.addShadow()
        
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(limitLabel)
        addSubview(checkmarkImageView)
        
        checkmarkImageView.anchor(left: self.leftAnchor, centerY: self.centerYAnchor, width: 15, height: 15, leftPadding: 25)
        titleLabel.anchor(top: self.topAnchor, left: checkmarkImageView.rightAnchor, topPadding: 20, leftPadding: 15)
        timeLabel.anchor(top: titleLabel.bottomAnchor, bottom: self.bottomAnchor, left: titleLabel.leftAnchor, bottomPadding: 20)
        limitLabel.anchor(left: titleLabel.rightAnchor, right: self.rightAnchor, centerY: self.centerYAnchor, width: 50, leftPadding: 10, rightPadding: 10)
    }
    
    private func addInnerShadow() {
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.masksToBounds = true
    }
    
    private func addOuterShadow() {
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.masksToBounds = false
    }
    
    private func hideShadow() {
        contentView.layer.shadowOpacity = 0.1
    }
    
    func setCell(title: String, time: Int, limit: String) {
        titleLabel.text = title
        timeLabel.text = String(time)
        limitLabel.text = limit
    }
    
}
