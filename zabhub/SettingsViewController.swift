//
//  SettingsViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 5/15/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit
import SwiftDate

class SettingsViewController: BaseViewController {
    
    var URL_ENDPOINT = "resync"
    
    @IBOutlet var btnReSync: UIButton!
    @IBOutlet var lblReSync: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if finish_time was stored last.
        let finish_time = self.preferences.string(forKey: Constants.PROFILE_LAST_SYNC_DATETIME_KEY)
        if finish_time != nil {
            // Show last synced datetime instead of sync button if resync is not possible.
            let (resync_possible, _) = self.resyncPossible(finish_time: finish_time!)
            if !resync_possible {
                self.lblReSync.text = Strings.getNaturalTime(dateString: finish_time!)
                self.btnReSync.isHidden = true
                self.lblReSync.isHidden = false
            }
        }
    }
    
    @IBAction func btnOnReSync(_ sender: AnyObject) {
        // Fetch credentials from shared utilities.
        let username = self.preferences.value(
            forKey: Constants.SECURITY_USERNAME_KEY) as! String
        let password = self.preferences.value(
            forKey: Constants.SECURITY_PASSWORD_KEY) as! String
        let request = Request(
            url: Constants.getAbsUrl(key: self.URL_ENDPOINT),
            parameters: [
                "username": username,
                "password": password,
                "token": Constants.TOKEN,
            ]
        )
        let data_dict = request.getData()
        let student_dict = data_dict["student"] as! [String: Any]
        let student_logs = student_dict["logs"] as! [String: Any]
        let finish_time = student_logs["finish_time"] as! String
        
        // Store the finish time in preferences.
        self.preferences.set(finish_time, forKey: Constants.PROFILE_LAST_SYNC_DATETIME_KEY)
        self.preferences.synchronize()
        
        self.lblReSync.text = Strings.getNaturalTime(dateString: finish_time)
        
        self.btnReSync.isHidden = true
        self.lblReSync.isHidden = false
    }
    
    @IBAction func btnOnLogOut(_ sender: AnyObject) {
        // Clear all data.
        self.clearData()
        // Move back to login view controller.
        self.present(Navigation.getLoginViewController(), animated: true, completion: nil)
    }
    
    func resyncPossible(finish_time: String) -> (Bool, DateInRegion) {
        let current_datetime = DateInRegion()
        let finish_datetime = Strings.strToDateInRegion(dateString: finish_time)
        let next_datetime = finish_datetime + 3.hours
        if current_datetime > next_datetime {
            return (true, finish_datetime)
        }
        return (false, finish_datetime)
    }
}
