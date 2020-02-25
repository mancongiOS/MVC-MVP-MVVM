//
//  MVVMDataModel.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/2/25.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

class MVVMDataModel: NSObject {
    @objc var picture: String = ""
    @objc var name: String = ""
    @objc var id: String = ""

    /// 是否喜欢
    @objc var isLike: Bool = false
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

