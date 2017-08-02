//
//  LoginViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 5/13/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    var URL_ENDPOINT = "register"
    var TABLE_NAME = "Profile"
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    @IBOutlet var txtFieldUsername: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var switchRemember: UISwitch!
    @IBOutlet var activityIndicatorLogin: UIActivityIndicatorView!
    
    func textFieldShouldReturn(_ txtFieldPassword: UITextField) -> Bool {
        self.view.endEditing(true)
        login()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if user marked his profile as `Remember Me`.
        let username = self.keychain.get("USERNAME")
        let password = self.keychain.get("PASSWORD")
        if username != nil && password != nil {
            // If yes, move the user to overview.
            self.present(
                Navigation.getMainTabBarController(),
                animated: true,
                completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldPassword.delegate = self
        // Check if user marked his profile as `Remember Me`.
        let username = self.keychain.get("USERNAME")
        let password = self.keychain.get("PASSWORD")
        if username != nil && password != nil {
            // Disable user interaction.
            self.view.isUserInteractionEnabled = false
            // If yes, move the user to overview.
            txtFieldUsername.text = username!
            txtFieldPassword.text = password!
        }
    }
    
    func login() {
        let username = self.txtFieldUsername.text!
        if username.isEmpty || username == "" {
            self.txtFieldUsername.placeholder = "Username is required."
            return
        }
        
        let password = self.txtFieldPassword.text!
        if password.isEmpty || password == "" {
            self.txtFieldPassword.placeholder = "Password is required."
            return
        }
        
        self.activityIndicatorLogin.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        let request = Request(
            url: Constants.getAbsUrl(key: self.URL_ENDPOINT),
            parameters: [
                "username": username,
                "password": password,
                "token": Constants.TOKEN,
                ]
        )
        let data = request.getData()
        if data["success"] as! Bool {
            // Store credentials in keychain if user marked his profile as `Remember Me`.
            if self.switchRemember.isOn {
                self.keychain.set(username, forKey: Constants.SECURITY_USERNAME_KEY)
                self.keychain.set(password, forKey: Constants.SECURITY_PASSWORD_KEY)
            }
            
            // Store credentials in UserDefaults.
            self.preferences.setValue(username, forKey: Constants.SECURITY_USERNAME_KEY)
            self.preferences.setValue(password, forKey: Constants.SECURITY_PASSWORD_KEY)
            self.preferences.synchronize()
            
            // Move to overview.
            self.present(
                Navigation.getMainTabBarController(),
                animated: true,
                completion: nil)
        } else {
            self.activityIndicatorLogin.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            // Message box to alert user about invalid credentials.
            let alert = UIAlertController(
                title: "Unable to Login",
                message: "Your username or password is incorrect!",
                preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(
                title: "Ok",
                style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnOnLogin(_ sender: AnyObject) {
        /* On `Login` Button Click */
        login()
    }
    
    @IBAction func btnOnForgot(_ sender: AnyObject) {
        /* On `Forgot` Button Click */
        let url = URL(string: Constants.ZABHUB_WEB_FORGOT_URL)!
        UIApplication.shared.open(url)
        
    }
}
