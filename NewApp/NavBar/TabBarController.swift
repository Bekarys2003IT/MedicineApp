//
//  TabBarControllerViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBars()
        self.tabBar.barTintColor = .lightGray
        self.tabBar.tintColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 100/255, green: 101/255, blue: 102/255, alpha: 1)
    }
   private func setBars(){
        let medicineVC = self.createNav(with: "Аптечки", and:UIImage(systemName:"cross.case"), vc: MedicineViewController())
        let profileVC = self.createNav(with: "О приложении", and: UIImage(systemName: "person"), vc: AboutAppViewController())
        self.setViewControllers([medicineVC,profileVC], animated: true)
    }
    private func createNav(with title:String, and image:UIImage?, vc:UIViewController)->UINavigationController{
        let nav  = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
