//
//  MenuTableViewCell.swift
//  Twitter
//
//  Created by Ping Zhang on 11/14/15.
//  Copyright © 2015 Ping Zhang. All rights reserved.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {
    private var _iconImageView: UIImageView!
    private var _functionLabel: UILabel!
    private var _statusLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        addLayout()
    }
    
    func addSubViews() {
        addSubview(iconImageView)
        addSubview(functionLabel)
        addSubview(statusLabel)
    }
    
    func addLayout() {
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TMenu.offset)
            make.left.equalTo(self).offset(TMenu.leftOffset)
            make.bottom.equalTo(self).offset(-TMenu.offset)
            make.height.equalTo(TMenu.iconSize)
            make.width.equalTo(TMenu.iconSize)
        }
        
        functionLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TMenu.offset)
            make.left.equalTo(iconImageView.snp_right).offset(TMenu.offset)
            make.bottom.equalTo(self).offset(-TMenu.offset)
            //make.height.equalTo(TMenu.functionHeight)
            make.width.equalTo(TMenu.functionWidth)
        }
        
        statusLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(TMenu.offset)
            make.bottom.equalTo(self).offset(-TMenu.offset)
            make.left.equalTo(functionLabel.snp_right).offset(TMenu.offset)
            //make.right.greaterThanOrEqualTo(self).offset(TMenu.offset)
        }
        
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        selectionStyle = UITableViewCellSelectionStyle.None
        backgroundColor = UIColor.clearColor()
    }
    
    func setMyAccountFunction(myAcocuntFuntion: MenuFunction) {
        iconImageView.image = UIImage(named: myAcocuntFuntion.icon)
        functionLabel.text = myAcocuntFuntion.name
        statusLabel.text = myAcocuntFuntion.status
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension MyAccountTableViewCell {
    var iconImageView: UIImageView {
        if _iconImageView == nil {
            _iconImageView = UIImageView()
        }
        return _iconImageView
    }
    
    var functionLabel: UILabel {
        if _functionLabel == nil {
            _functionLabel = UILabel()
            _functionLabel.font = TMenu.functionFont
            _functionLabel.textColor = TMenu.fontColor
        }
        return _functionLabel
    }
    
    var statusLabel: UILabel {
        if _statusLabel == nil {
            _statusLabel = UILabel()
            _statusLabel.textColor = TMenu.fontColor
            _statusLabel.font = TMenu.functionFont
        }
        return _statusLabel
    }
}

