//
//  Navigation.swift
//  zabhub
//
//  Created by ZabHub Team on 5/14/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import Foundation
import UIKit


class Navigation {
    
    static var storyBoard: UIStoryboard {
        get {
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    static func getLoginViewController() -> LoginViewController {
        return storyBoard.instantiateViewController(
            withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    static func getOverviewController() -> OverviewController {
        return storyBoard.instantiateViewController(
            withIdentifier: "OverviewController") as! OverviewController
    }
    
    static func getMainTabBarController() -> UITabBarController {
        return storyBoard.instantiateViewController(
            withIdentifier: "MainTabBarController") as! UITabBarController
    }
    
    static func getCoursesTabBarController() -> UITabBarController {
        return storyBoard.instantiateViewController(
            withIdentifier: "CoursesTabBarController") as! UITabBarController
    }
    
    static func getMarksViewController() -> MarksViewController {
        return storyBoard.instantiateViewController(
            withIdentifier: "MarksViewController") as! MarksViewController
    }
}
