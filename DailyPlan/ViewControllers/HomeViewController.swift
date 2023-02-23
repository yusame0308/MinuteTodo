//
//  HomeViewController.swift
//  DailyPlan
//
//  Created by 小原宙 on 2022/09/22.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    private let cellId = "cellId"
    
    var titles: [String] = ["0番上のセル", "セル", "2番目のセルテストテストあああああああああああああああああああ", "test", "test", "test", "test", "test", "test", "test", "test", "test"]
    var times: [Int] = [30, 40, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120]
    var limits: [String] = ["11/1", "11/12", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25"]
    
    var taskItems: Results<Task>!
    
    lazy var taskTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.contentInsetAdjustmentBehavior = .never
        tv.register(TaskTableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 25
        button.tintColor = .systemGray
        button.backgroundColor = .white
        button.addShadow()
        button.addAction(UIAction { [self] _ in
            self.showModal()
        }, for: .primaryActionTriggered)
        return button
    }()
    
    let bottomSeparator: UIView = {
        let bs = UIView()
        bs.backgroundColor = .systemGray5
        return bs
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        taskItems = realm.objects(Task.self)
        
        setupLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        taskTableView.anchor(top: view.topAnchor, topPadding: view.safeAreaInsets.top)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(taskTableView)
        view.addSubview(bottomSeparator)
        view.addSubview(addButton)
        
        taskTableView.anchor(left: view.leftAnchor, right: view.rightAnchor)
        bottomSeparator.anchor(bottom: taskTableView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 2)
        addButton.anchor(top: taskTableView.bottomAnchor, bottom: view.bottomAnchor, centerX: view.centerXAnchor, width: 50, height: 50, topPadding: 15, bottomPadding: 30)
    }
    
    private func showModal() {
        let vc = AddViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        vc.presentationController?.delegate = self
        present(vc, animated: true, completion: { [self] in
            taskTableView.contentInset.bottom = self.view.frame.height/2-50
        })
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskTableViewCell
        cell.setCell(title: titles[indexPath.row], time: times[indexPath.row], limit: limits[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Edit
        let editAction = UIContextualAction(style: .normal  , title: "edit") {
            (ctxAction, view, completionHandler) in
            print("edit")
            completionHandler(true)
        }
        let editImage = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
        editAction.image = editImage
        editAction.backgroundColor = .systemBlue
        
        // Delete
        let deleteAction = UIContextualAction(style: .destructive, title:"delete") {
            (ctxAction, view, completionHandler) in
            print("delete")
            completionHandler(true)
        }
        let deleteImage = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
        deleteAction.image = deleteImage
        deleteAction.backgroundColor = .systemRed
        
        let swipeAction = UISwipeActionsConfiguration(actions:[deleteAction, editAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
}

extension HomeViewController: UIAdaptivePresentationControllerDelegate {
    //Modalのdismissを検知
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.taskTableView.contentInset.bottom = 0
        }, completion: nil)
    }
}
