//
//  UIView-Extension.swift
//  DailyPlan
//
//  Created by 小原宙 on 2022/10/19.
//

import UIKit

extension UIView {
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        topPadding: CGFloat = 0,
        bottomPadding: CGFloat = 0,
        leftPadding: CGFloat = 0,
        rightPadding: CGFloat = 0) {
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
            }
            
            if let bottom = bottom {
                self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
            }
            
            if let left = left {
                self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
            }
            
            if let right = right {
                self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
            }
            
            if let centerY = centerY {
                self.centerYAnchor.constraint(equalTo: centerY).isActive = true
            }
            
            if let centerX = centerX {
                self.centerXAnchor.constraint(equalTo: centerX).isActive = true
            }
            
            if let width = width {
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            
        }
    
    func addInnerShadow() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    func addOuterShadow() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
}
