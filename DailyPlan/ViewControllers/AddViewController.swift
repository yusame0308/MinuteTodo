//
//  AddViewController.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/10.
//

import UIKit

class AddViewController: UIViewController {
    let titleTextField = AddTextField(placeHolder: "タイトル")
    let lengthTextField = AddTextField(placeHolder: "所要時間", type: .numberPad, fontSize: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 0.95)
        
        let baseStackView = UIStackView(arrangedSubviews: [titleTextField, lengthTextField])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillProportionally
        baseStackView.alignment = .center
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        
        titleTextField.anchor(left: baseStackView.leftAnchor, right: baseStackView.rightAnchor, height: 40)
        lengthTextField.anchor(width: 80, height: 30)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 60, rightPadding: 60)
    }
}
