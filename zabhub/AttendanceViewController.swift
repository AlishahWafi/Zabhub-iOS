//
//  AttendanceViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 6/3/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class AttendanceViewController: BaseTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell", for: indexPath)
        let marks = self.data[indexPath.row]
        
        let datetime = marks["datetime"] as! String
        let present = marks["present"] as! Int
        let late = marks["late"] as! Int
        
        cell.textLabel?.text = datetime
        cell.detailTextLabel?.text = getAttendanceText(present: present, late: late)
        return cell;
    }
    
    func getAttendanceText(present: Int, late: Int) -> String {
        /* Return attendance text (i.e. 12/14) */
        var present_text = "Present"
        if present == 0 {
            present_text = "Absent"
        } else if present == 1 && late == 1 {
            present_text = "Late"
        }
        return present_text
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        /* On `Back` Button Click */
        self.present(
            Navigation.getMainTabBarController(),
            animated: true,
            completion: nil
        )
    }
}
