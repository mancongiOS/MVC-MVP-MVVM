//
//  MVPProtocol.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/10.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


/// Presenter向V层下达命令，V层需要依照命令来做事
protocol MVPViewProtocol: NSObjectProtocol {
    /// 展示数据
    func reloadData()
    /// 展示指示器
    func showIndicator()
    /// 隐藏指示器
    func hideIndicator()
    /// 展示空页面
    func showEmptyView()
    
    /// 更新单个indexPath
    func reloadDataAt(indexPath: IndexPath)
}

