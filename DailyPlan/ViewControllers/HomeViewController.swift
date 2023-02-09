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
    
    var titles: [String] = ["0番上のセル", "セル", "2番目のセルテストテストあああああああああああああああああああ", "test", "test", "test", "test", "test", "test"]
    var times: [Int] = [30, 40, 120, 120, 120, 120, 120, 120, 120]
    var limits: [String] = ["11/1", "11/12", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25", "11/25"]
    
    var taskItems: Results<Task>!
    
    lazy var taskTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(TaskTableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        taskItems = realm.objects(Task.self)
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .green
        
        view.addSubview(taskTableView)
        
        taskTableView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
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
    
}
