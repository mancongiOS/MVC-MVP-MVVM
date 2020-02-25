//
//  MVCCell.swift
//  DesignPatterns
//
//  Created by 满聪 on 2020/1/7.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher


protocol MVCCellDelegate: NSObjectProtocol {
    /// 点击了喜欢按钮
    func mvcCell(_ cell: MVCCell, didLike model: MVCModel)
}

class MVCCell: UITableViewCell {

    public weak var delegate: MVCCellDelegate?
    
    public var model = MVCModel() {
        didSet {
            nameLabel.text = model.name
            let url = URL(string: model.picture)
            iconImageView.kf.setImage(with: url)
            
            likeButton.isSelected = model.isLike
        }
    }
    
        
    public class func customCell(tableView: UITableView) -> MVCCell {
        
        let reuseIdentifier = GetClassName(self.classForCoder())
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            cell = MVCCell.init(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell as! MVCCell
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView()

        iv.backgroundColor = UIColor.gray
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.text = "名称"
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "unlike"), for: .normal)
        btn.setImage(UIImage.init(named: "like"), for: .selected)
        btn.addTarget(self, action: #selector(likeEvent), for: .touchUpInside)
        return btn
    }()
}


extension MVCCell {
    @objc func likeEvent() {
        delegate?.mvcCell(self, didLike: model)
    }
}


extension MVCCell {
    
    func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(iconImageView.snp.height)
        }
        
        nameLabel.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalTo(iconImageView)
        }
        
        likeButton.snp.remakeConstraints { (make) ->Void in
            make.right.equalTo(-15)
            make.centerY.equalTo(iconImageView)
            make.width.height.equalTo(40)
        }
    }
}
