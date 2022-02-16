//
//  TableViewCell.swift
//  TwitterSlideOutMenu
//
//  Created by braindamage on 2022/2/14.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK: - Model
    static let cellID = "TableViewCell"
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
