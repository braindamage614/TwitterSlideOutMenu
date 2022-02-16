//
//  ViewController.swift
//  TwitterSlideOutMenu
//
//  Created by braindamage on 2022/2/14.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    private let menuWidth: CGFloat = 300
    
    private var menuController: MenuTableViewController = MenuTableViewController()
    


}

//MARK: - LifeCycle
extension HomeTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupViews()
    }
}

//MARK: - SetupUI
extension HomeTableViewController {
    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        
        setupPanGesture()
    }
    private func setupNavigationBar() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(leftBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(rightBarButtonItemTapped(_:)))
        
    }
    private func setupTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.cellID)
    }
    
    private func setupMenuController() {

    }
    
    private func setupPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(viewDidPan(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(pan)
    }
}


//MARK: - Action
extension HomeTableViewController {
    @objc func leftBarButtonItemTapped(_ sender: UIBarButtonItem) {
        addMenuView()
    }
    
    @objc func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
        removeMenuView()
    }
    
    /**    /// 1.注意左右边界 2.注意手势停止时的状态

     */
    @objc func viewDidPan(_ sender: UIPanGestureRecognizer) {
        if menuController.parent != self {
            /// 分屏应用不可以这么用
            menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
            /*
             1.UIWindow 是 UIView 的 SubClass
             2.StackOverFlow & Blog Posts Open Source Projects
             */
            if let mainWindow = UIApplication.shared.keyWindow {
                mainWindow.addSubview(menuController.view)
            }
            /*
             1.addChild 否则Cell 不显示 不知道为什么
             2.
             */
            addChild(menuController)
        }

        if sender.state == .changed {
            var translation = sender.translation(in: view)
            var positionX = min(menuWidth, translation.x)
            positionX = max(0, positionX)
            // drag menu
            menuController.view.transform = CGAffineTransform(translationX: positionX, y: 0)
            navigationController?.view.transform = CGAffineTransform(translationX: positionX, y: 0)
        } else if sender.state == .ended {
            showMenuController()
        }
    }
}

//MARK: - Slide
extension HomeTableViewController {
    private func addMenuView() {
        if menuController.parent != self {
            /// 分屏应用不可以这么用
            menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
            /*
             1.UIWindow 是 UIView 的 SubClass
             2.StackOverFlow & Blog Posts Open Source Projects
             */
            if let mainWindow = UIApplication.shared.keyWindow {
                mainWindow.addSubview(menuController.view)
            }
            /*
             1.addChild 否则Cell 不显示 不知道为什么
             2.
             */
            addChild(menuController)
        }
        showMenuController()
    }
    
    private func removeMenuView() {
        dismissMenuController()
        ///不需要删除了
        //menuController.view.removeFromSuperview()
        ///否则下一次Show会报错
        //menuController.removeFromParent()
    }
}

//MARK: - Animation
extension HomeTableViewController {
    private func showMenuController() {
        perfromMenuControllerTransform(.init(translationX: menuWidth, y: 0))
    }
    
    private func dismissMenuController() {
        perfromMenuControllerTransform(.identity)
    }
    
    private func perfromMenuControllerTransform(_ transfrom: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            guard let self = self else {return}
            self.menuController.view.transform = transfrom //Menu TransForm
            //self.view.transform = transfrom // view need transform too, but navigation bar don't not move
            self.navigationController?.view.transform = transfrom
        } completion: { finish in
            if finish {
                //TODO: 待定
            }
        }

    }
}

//MARK: - UITableViewDataSourcr
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellID, for: indexPath) as! HomeTableViewCell
        ///iOS 14 更新后的Cell方式
        var content = cell.defaultContentConfiguration()
        content.text = "Row \(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HomeTableViewController {
    
}
