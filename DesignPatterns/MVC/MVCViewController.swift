//
//  MVCViewController.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

class MVCViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.center = view.center
        self.view.addSubview(indicatorView)
        
        tableView.rowHeight = 100
        sendNetworking()
    }
    
    
    lazy var dataSource: [MVCModel] = []
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = UIActivityIndicatorView.Style.large
        view.hidesWhenStopped = true
        return view
    }()
}

extension MVCViewController {
    func sendNetworking() {
        
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        /// 模拟网络请求
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let arr = Tool.loadJson()
            
            arr.forEach {
                let entity = MVCModel()
                entity.setValuesForKeys($0)
                self.dataSource.append(entity)
            }
            self.indicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }
}


extension MVCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MVCCell.customCell(tableView: tableView)
        cell.model = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        model.isLike = !model.isLike
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
