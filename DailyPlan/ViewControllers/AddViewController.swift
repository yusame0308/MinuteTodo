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
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.text = "分"
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    lazy var limitTextField = LimitTextField()
    lazy var clearButton = UIButton().createClearButton {
        self.limitTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 0.95)
        
        let baseStackView = UIStackView(arrangedSubviews: [titleTextField, lengthTextField, limitTextField])
        baseStackView.axis = .vertical
        baseStackView.distribution = .equalSpacing
        baseStackView.alignment = .center
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(minuteLabel)
        view.addSubview(clearButton)
        
        titleTextField.anchor(left: baseStackView.leftAnchor, right: baseStackView.rightAnchor, height: 40)
        lengthTextField.anchor(width: 80, height: 30)
        minuteLabel.anchor(left: lengthTextField.rightAnchor, centerY: lengthTextField.centerYAnchor, leftPadding: 4)
        limitTextField.anchor(height: 30)
        clearButton.anchor(left: limitTextField.rightAnchor, centerY: limitTextField.centerYAnchor, leftPadding: 4)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 60, rightPadding: 60)
    }
}
