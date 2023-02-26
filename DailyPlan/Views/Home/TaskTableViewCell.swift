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
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
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
    
    let editButton = SwipeButton(imageName: "square.and.pencil", color: .systemBlue)
    
    let deleteButton = SwipeButton(imageName: "trash", color: .systemRed, radius: 4)
    
    lazy var titleLabelInitialWidth = titleLabel.frame.width
    
    var showsSwipeButtons: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.setPositions(x: self.showsSwipeButtons ? -140 : 0)
            }, completion: nil)
        }
    }
    
    var isSwiping = false
    
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
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if showsSwipeButtons && !isSwiping {
            setPositions(x: -140)
        }
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
        addSubview(editButton)
        addSubview(deleteButton)
        
        checkmarkImageView.anchor(left: self.leftAnchor, centerY: self.centerYAnchor, width: 15, height: 15, leftPadding: 25)
        titleLabel.anchor(top: self.topAnchor, left: checkmarkImageView.rightAnchor, topPadding: 20, leftPadding: 15)
        timeLabel.anchor(top: titleLabel.bottomAnchor, bottom: self.bottomAnchor, left: titleLabel.leftAnchor, bottomPadding: 20)
        limitLabel.anchor(left: titleLabel.rightAnchor, right: self.rightAnchor, centerY: self.centerYAnchor, width: 50, leftPadding: 10, rightPadding: 10)
        editButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, width: 0, topPadding: 8, bottomPadding: 8)
        deleteButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor, left: editButton.rightAnchor, right: self.rightAnchor, width: 0, topPadding: 8, bottomPadding: 8, rightPadding: 10)
        
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
    
    private func setupActions() {
        let swipeGesture = HorizontalPanGestureRecognizer(target: self, action: #selector(swipeAction))
        self.contentView.addGestureRecognizer(swipeGesture)
    }
    
}

// Gesture Actions
extension TaskTableViewCell {
    
    @objc private func swipeAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        var x = translation.x
        if showsSwipeButtons {
            x -= 140
        }
        
        switch gesture.state {
        case .began:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.isSwiping = true
            }
        case .changed:
            self.handleSwipeChanged(x: x)
        case .ended:
            self.handleSwipeEnded(x: x)
            self.isSwiping = false
        default:
            break
        }
    }
    
    private func handleSwipeChanged(x: CGFloat) {
        switch x {
        case ...(-140):
            setPositions(x: -140)
        case 0...:
            setPositions(x: 0)
        default:
            setPositions(x: x)
        }
    }
    
    private func handleSwipeEnded(x: CGFloat) {
        showsSwipeButtons = showsSwipeButtons ? x < -100 : x < -40
    }
    
    private func setPositions(x: CGFloat) {
        self.limitLabel.transform = CGAffineTransform(translationX: x, y: 0)
        self.titleLabel.frame.size.width = titleLabelInitialWidth + x
        
        self.editButton.frame.size.width = -x / 2
        self.editButton.transform = CGAffineTransform(translationX: x + 0.1, y: 0)
        self.deleteButton.frame.size.width = -x / 2
        self.deleteButton.transform = CGAffineTransform(translationX: x / 2, y: 0)
    }
    
}
