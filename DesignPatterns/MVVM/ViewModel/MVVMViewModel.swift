//
//  MVVMViewModel.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/2/25.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

typealias ClickClosure = (IndexPath) -> Void

class MVVMViewModel: NSObject {

    public var clickClosure: ClickClosure?
    public var dataArray: [MVVMDataModel] = []
    
    func requestData( success: () -> Void) {
        let arr = Tool.loadJson()
          
          arr.forEach {
              let entity = MVVMDataModel()
              entity.setValuesForKeys($0)
              self.dataArray.append(entity)
          }
        success()
    }
}



extension MVVMViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MVVMCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MVVMCell.self)) as! MVVMCell
        cell.indePath = indexPath
        cell.model = dataArray[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension MVVMViewModel: MVVMCellDelegate {
    func mvvmCell(_ cell: MVVMCell, didSelectAtRow row: IndexPath) {
        clickClosure?(row)
    }
}
