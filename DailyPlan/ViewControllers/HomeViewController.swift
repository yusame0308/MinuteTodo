//
//  HomeViewController.swift
//  DailyPlan
//
//  Created by 小原宙 on 2022/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let cellId = "cellId"
    
    var exampleArray: [String] = ["0番上のセル", "1番目のセル", "2番目のセル"]
    
    lazy var taskTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 70
        tv.separatorColor = UIColor.blue
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return exampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellId)
        cell.textLabel?.text = exampleArray[indexPath.row]
        
        return cell
    }
    
}
