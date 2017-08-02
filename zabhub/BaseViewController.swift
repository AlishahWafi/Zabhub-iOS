//
//  BaseViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 5/14/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit
import KeychainSwift

class BaseViewController: UIViewController, UITextFieldDelegate {
    
    let keychain = KeychainSwift()
    let preferences = UserDefaults.standard
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clearData() {
        /* Clears `Keychain` and `UserDefaults` data */
        // Delete credentials from keychain.
        self.keychain.clear()
        // Clear UserDefaults.
        self.preferences.removeObject(forKey: Constants.SECURITY_USERNAME_KEY)
        self.preferences.removeObject(forKey: Constants.SECURITY_PASSWORD_KEY)
        self.preferences.removeObject(forKey: Constants.PROFILE_LAST_SYNC_DATETIME_KEY)
        self.preferences.synchronize()
    }
}
