//
//  TabController.swift
//  XylophoneSNP
//
//  Created by yunus on 26.10.2024.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.barTintColor = .lightGray
    }
    private func setupTabs(){
        let mainVC = createNav(title: "Xylophone", image: UIImage(systemName: "switch.programmable"), vc: ViewController())
        let recVC = createNav(title: "History", image: UIImage(systemName: "chart.bar.horizontal.page"), vc: RecordingViewController())

        self.setViewControllers([mainVC, recVC], animated: true)
    }
    private func createNav(title: String, image: UIImage?, vc: UIViewController)-> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.title = title
        
        return nav
    }
}
