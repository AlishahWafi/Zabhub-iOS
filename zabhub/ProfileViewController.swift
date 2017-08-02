//
//  ProfileViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 5/15/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: BaseTableViewController {

    var URL_ENDPOINT = "profile"
    var refreshControl: UIRefreshControl!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch data.
        self.fetchData()
        // Pull to refresh.
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath)
        let profile = self.data[indexPath.row]
        var keys = Array<String>(profile.keys)
        cell.textLabel?.text = keys[0]
        cell.detailTextLabel?.text = "\(profile[keys[0]]!)"
        return cell;
    }
    
    func refresh(sender: AnyObject) {
        // Fetch data.
        self.fetchData()
        // Reload table view with fetched data.
        self.tableView.reloadData()
        // End refreshing.
        self.refreshControl.endRefreshing()
    }
    
    func fetchData() {
        /* Fetch profile data */
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
        if data_dict["success"] as! Bool {
            let student_dict = data_dict["student"] as! [String: Any]
            self.data = [
                ["First Name": student_dict["first_name"]!],
                ["Last Name": student_dict["last_name"]!],
                ["Username": student_dict["username"]!],
                ["CGPA": student_dict["cgpa"]!],
                ["Progress": student_dict["progress"]!],
                ["Email": student_dict["email"]!],
                ["Gender": student_dict["gender"]!],
                ["Date of Birth": student_dict["dob"]!],
                ["Blood Group": student_dict["blood_group"]!],
                ["Mobile No.": student_dict["mobile"]!],
                ["City": student_dict["city"]!],
                ["Country": student_dict["country"]!],
                ["Address": student_dict["address"]!],
            ]
        }
    }
}
