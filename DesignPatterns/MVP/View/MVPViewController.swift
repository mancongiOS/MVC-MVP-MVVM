//
//  MVPViewController.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

class MVPViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MVP"
    
        indicatorView.center = CGPoint.init(x: view.frame.size.width / 2, y: 200)
        self.view.addSubview(indicatorView)
        
        
        /// 获取数据
        presenter.fetchData()
        
        
        // 设置tableView的属性和代理
        tableView.rowHeight = 100
        tableView.delegate = presenter
        tableView.dataSource = presenter
    }
    
    
    lazy var presenter: Presenter = {
        let p = Presenter()
        p.attachView(view: self)
        return p
    }()
    
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = UIActivityIndicatorView.Style.large
        view.hidesWhenStopped = true
        return view
    }()
}




extension MVPViewController: MVPViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showIndicator() {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }
    
    func hideIndicator() {
        indicatorView.stopAnimating()
    }
    
    func showEmptyView() {
        let alertC = UIAlertController.init(title: "展示空页面", message: nil, preferredStyle: .alert)
        let sure = UIAlertAction.init(title: "sure", style: .cancel, handler: nil)
        alertC.addAction(sure)
        self.present(alertC, animated: true, completion: nil)
    }
    
    func reloadDataAt(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

