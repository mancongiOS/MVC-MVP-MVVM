//
//  MVVMViewController.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit
import MJRefresh

class MVVMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVVM"
        layout()
        sendNetworking()
    }
    
    lazy var dataView: MVVMView = {
        let view = MVVMView()
        view.tableView.delegate = viewModel
        view.tableView.dataSource = viewModel
        return view
    }()
    
    lazy var viewModel: MVVMViewModel = {
        let vd = MVVMViewModel()
        return vd
    }()
}

extension MVVMViewController {
    func layout() {
        view.addSubview(dataView)
        dataView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
    }
    
    func sendNetworking() {
        viewModel.requestData { [weak self] in
            self?.dataView.tableView.reloadData()
        }
        viewModel.clickClosure = { [weak self] indexPath in
            self?.dataView.tableView
                .reloadRows(at: [indexPath], with: .fade)
        }
        
        dataView.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.dataView.tableView.mj_header?
                .endRefreshing()
            self.dataView.tableView.reloadData()
        })
    }
}
