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
    
    var taskItems: Results<Task>!
    
    lazy var taskTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.contentInsetAdjustmentBehavior = .never
        tv.showsVerticalScrollIndicator = false
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
            sheet.preferredCornerRadius = 40
        }
        vc.presentationController?.delegate = self
        present(vc, animated: true, completion: { [self] in
            taskTableView.contentInset.bottom = self.view.frame.height/2-50
        })
    }
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskTableViewCell
        cell.setModel(task: taskItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        cell.updateIsDoneAndSetStyle()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        for c in taskTableView.visibleCells {
            let cell = c as! TaskTableViewCell
            if cell.showsSwipeButtons {
                cell.showsSwipeButtons = false
            }
        }
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
