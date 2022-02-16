//
//  MenuTableViewCell.swift
//  TwitterSlideOutMenu
//
//  Created by braindamage on 2022/2/15.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    static let cellID = "MenuTableViewCellID"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
