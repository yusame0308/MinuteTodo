//
//  AddViewController.swift
//  DailyPlan
//
//  Created by 小原宙 on 2023/02/10.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    private let isEdit: Bool
    private var task: Task?
    
    private let gradientLayer = CAGradientLayer()
    let titleTextField = AddTextField(placeHolder: "タイトル")
    let lengthTextField = AddTextField(placeHolder: "所要時間", type: .numberPad, fontSize: 15)
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.text = "分"
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    lazy var limitTextField = LimitTextField(action: changeClearButtonAlpha)
    lazy var clearButton = UIButton().createClearButton {
        self.limitTextField.text = ""
        self.changeClearButtonAlpha()
    }
    lazy var addButton = UIButton().createSimpleButton(title: isEdit ? "完了" : "追加") {
        self.isEdit ? self.updateTask() : self.addTask()
        let pVC = self.presentingViewController as! HomeViewController
        pVC.taskTableView.closeAllCellsSwipeButton()
        pVC.taskTableView.reloadData()
        if let presentationController = self.presentationController {
            presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
        }
        self.dismiss(animated: true)
    }
    
    init(isEdit: Bool = false, task: Task?) {
        self.isEdit = isEdit
        self.task = task
        super.init(nibName: nil, bundle: nil)
        
        if let task = self.task {
            self.setupTextFields(task: task)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupActions()
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemGray6.withAlphaComponent(0.9).cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 0.2]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [titleTextField, lengthTextField, limitTextField])
        baseStackView.axis = .vertical
        baseStackView.distribution = .equalSpacing
        baseStackView.alignment = .center
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(minuteLabel)
        view.addSubview(clearButton)
        view.addSubview(addButton)
        
        minuteLabel.alpha = self.lengthTextField.isEmpty ? 0 : 1
        clearButton.alpha = self.limitTextField.isEmpty ? 0 : 1
        addButton.alpha = self.titleTextField.isEmpty ? 0.4 : 1.0
        addButton.isEnabled = !self.titleTextField.isEmpty
        
        titleTextField.anchor(left: baseStackView.leftAnchor, right: baseStackView.rightAnchor, height: 40)
        lengthTextField.anchor(width: 80, height: 30)
        minuteLabel.anchor(left: lengthTextField.rightAnchor, centerY: lengthTextField.centerYAnchor, leftPadding: 3)
        limitTextField.anchor(height: 30)
        clearButton.anchor(left: limitTextField.rightAnchor, centerY: limitTextField.centerYAnchor, leftPadding: 3)
        addButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, width: 80, height: 40, topPadding: 40)
        baseStackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: view.frame.height/4-80, leftPadding: 60, rightPadding: 60)
    }
    
    private func setupActions() {
        
        titleTextField.addAction(UIAction { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut], animations: {
                if self.titleTextField.isEmpty {
                    self.addButton.alpha = 0.4
                    self.addButton.isEnabled = false
                } else {
                    self.addButton.alpha = 1.0
                    self.addButton.isEnabled = true
                }
            }, completion: nil)
        }, for: .editingChanged)
        
        lengthTextField.addAction(UIAction { _ in
            UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseInOut], animations: {
                self.minuteLabel.alpha = self.lengthTextField.isEmpty ? 0 : 1
            }, completion: nil)
        }, for: .editingChanged)
        
    }
    
    private func changeClearButtonAlpha() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveEaseInOut], animations: {
            self.clearButton.alpha = self.limitTextField.isEmpty ? 0 : 1
        }, completion: nil)
    }
    
    private func addTask() {
        let task = Task()
        
        task.title = self.titleTextField.text!
        if !self.lengthTextField.isEmpty {
            task.length = Int(lengthTextField.text!)
        }
        if !self.limitTextField.isEmpty {
            task.limit = self.limitTextField.selectedDate
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(task)
        }
    }
    
    private func updateTask() {
        guard let task = self.task else { return }
        
        let realm = try! Realm()
        try! realm.write {
            task.title = self.titleTextField.text!
            if !self.lengthTextField.isEmpty {
                task.length = Int(lengthTextField.text!)
            }
            if !self.limitTextField.isEmpty {
                task.limit = self.limitTextField.selectedDate
            }
        }
    }
    
    private func setupTextFields(task: Task) {
        self.titleTextField.text = task.title
        if let length = task.length {
            self.lengthTextField.text = String(length)
        }
        if let limit = task.limit {
            self.limitTextField.selectedDate = limit
        }
    }
}
