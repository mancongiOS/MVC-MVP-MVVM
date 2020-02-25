//
//  Tool.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit



class Tool: NSObject {
    
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





typealias DataSuccess = ([MVCModel]) -> Void



public func GetClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}
