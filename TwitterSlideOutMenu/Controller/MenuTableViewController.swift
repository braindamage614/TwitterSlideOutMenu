//
//  MenuTableViewController.swift
//  TwitterSlideOutMenu
//
//  Created by braindamage on 2022/2/15.
//

import UIKit

class MenuTableViewController: UITableViewController {

    
}

//MARK: - LifeCycle
extension MenuTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemYellow
        setupUI()
    }
}

//MARK: - SetupUI
extension MenuTableViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.cellID)
    }
}

//MARK: - UITableViewDataSource
extension MenuTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellID, for: indexPath) as! MenuTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = "Row \(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }
}
