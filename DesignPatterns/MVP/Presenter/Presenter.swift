//
//  Presenter.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/10.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class Presenter: NSObject {
    
    /// 列表的数据源
    private var dataSource: [MVPModel] = []

    private var attachView: MVPViewProtocol!

    /**
     将一个实现了 MVPProtocol 协议的对象绑定到 presenter上来
     此时的view是 控制器。
     目的就是为了将实现了MVPProtocol 协议的对象（就是控制器，因为view的直接操作者就是view Controller）绑定到presenter 上，也就是presenter 可以直接拿到实现了MVPProtocol 协议的对象，并且向他发送命令。
     */
    public func attachView(view: MVPViewProtocol) {
        
        attachView = view
    }
    
    /// 获取网络数据
    public func fetchData() {
        getData()
    }
    
    private func getData() {
        attachView.showIndicator()
        
        MVPNetwork.fetchDatasSuccessBlock { (models) in
            /// 模拟网络请求
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.dataSource.removeAll()

                self.attachView.hideIndicator()

                let arr = Tool.loadJson()
                
                arr.forEach {
                    let entity = MVPModel()
                    entity.setValuesForKeys($0)
                    self.dataSource.append(entity)
                }
                
                if self.dataSource.count == 0 {
                    self.attachView.showEmptyView()
                } else {
                    self.attachView.reloadData()
                }
            }
        }
    }
    
    /// 网络请求 -> 喜欢 or 不喜欢
    func editLike(model:MVPModel, callBack: (MVPModel) -> Void) {
        // 模拟网络请求，修改喜欢状态
        model.isLike = !model.isLike
        // 修改完成，闭包回调
        callBack(model)
    }
}


/// tableView的代理 应该放presenter里面还是就是控制器里面？
extension Presenter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MVPCell.customCell(tableView: tableView)
        cell.model = dataSource[indexPath.row]
        cell.delegate = self
        return cell
    }
}



extension Presenter: MVPCellDelegate {
    /// 点击了喜欢按钮的代理方法
    func mvpCell(_ cell: MVPCell, didLike model: MVPModel) {
        /// 处理点击事件, 更新V层
        editLike(model: model) { (newModel) in
            self.updateView(model: newModel)
        }
    }
    
    func updateView(model: MVPModel) {
        var i: Int = -1
        for (index, item) in dataSource.enumerated() {

            if item.id == model.id {
                i = index
                break
            }
        }
        if i < 0 { return }

        let indexPath = IndexPath.init(row: i, section: 0)
        attachView.reloadDataAt(indexPath: indexPath)
    }
}


