//
//  MVVMView.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/2/25.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

class MVVMView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        self.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.zero)
        tb.rowHeight = 80
        tb.register(MVVMCell.self, forCellReuseIdentifier: NSStringFromClass(MVVMCell.self))
        return tb
    }()

}
