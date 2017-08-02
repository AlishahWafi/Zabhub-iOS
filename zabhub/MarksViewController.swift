//
//  MarksViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 6/2/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class MarksViewController: BaseTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarksTableViewCell", for: indexPath)
        let marks = self.data[indexPath.row]
        
        let type = marks["type"] as! String
        let obtained = marks["obtained"] as! Float
        let total = marks["total"] as! Float
        
        cell.textLabel?.text = type
        cell.detailTextLabel?.text = "\(obtained)/\(total)"
        return cell;
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
