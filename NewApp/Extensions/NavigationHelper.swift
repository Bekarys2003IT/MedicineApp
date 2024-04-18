//
//  Back.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 17.04.2024.
//

import Foundation
import UIKit
class NavigationHelper {
    /// Pops the current view controller from the navigation stack.
    static func popViewController(from viewController: UIViewController) {
        if let navigationController = viewController.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
