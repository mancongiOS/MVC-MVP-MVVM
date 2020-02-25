//
//  MVPNetwork.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/10.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class MVPNetwork: NSObject {

    public static func fetchDatasSuccessBlock( success: @escaping DataSuccess) {
        
        var dataSource: [MVCModel] = []
        /// 模拟网络请求
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let arr = MVPNetwork.loadJson()
            
            arr.forEach {
                let entity = MVCModel()
                entity.setValuesForKeys($0)
                dataSource.append(entity)
            }
            success(dataSource)
        }
    }
}


extension MVPNetwork {
    
    /// 加载本地json数据
    static func loadJson() -> [[String: Any]] {
        if let path = Bundle.main.path(forResource: "animal", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)

            do {
                let data = try Data(contentsOf: url)
                let jsonData: [[String: Any]] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : Any]]
                return jsonData
            } catch let error {
                print("解析 animal json文件异常 \(error)")
            }
        }
        return []
    }
}
