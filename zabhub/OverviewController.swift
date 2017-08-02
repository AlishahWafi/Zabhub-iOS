//
//  OverviewController.swift
//  zabhub
//
//  Created by ZabHub Team on 5/14/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class OverviewController: BaseTableViewController {

    var URL_ENDPOINT = "courses"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableCell", for: indexPath) as! OverviewTableCell
        let course = self.data[indexPath.row]
        let courseInfo = course["course"] as! [String: Any]
        cell.lblCourseName.text! = (courseInfo["name"] as! String)
        
        // Check if teacher name's empty.
        var teacher = course["teacher"] as! String
        if teacher.isEmpty || teacher == "" {
            teacher = "Not Available"
        }
        cell.lblTeacherName.text! = teacher
        
        cell.lblMarks.text! = (course["marks_text"] as! String) + " marks"
        cell.lblAttendance.text! = (course["attendance_text"] as! String) + " attendance"
        let section = course["section"] as! [String: Any]
        cell.lblSection.text! = (section["name"] as! String)
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Handles course item click  */
        var courseData = self.data[indexPath.row]
        
        let tabBarController = Navigation.getCoursesTabBarController()
        var viewControllers = tabBarController.viewControllers
        
        // `Marks` and `Attendance` data lists.
        let marks = courseData["marks"] as! Array<[String: Any]>
        let attendance = courseData["attendance"] as! Array<[String: Any]>
        
        // Set marks data.
        let marksViewController = viewControllers?[0] as! MarksViewController
        marksViewController.data = marks
        
        // Set attendance data.
        let attendanceViewController = viewControllers?[1] as! AttendanceViewController
        attendanceViewController.data = attendance
        
        if marks.isEmpty && attendance.isEmpty {
            // `Marks` and `Attendance` are both empty.
            // Remove all controllers and do not move.
            viewControllers?.removeAll()
        } else if !marks.isEmpty || !attendance.isEmpty {
            // At least one of them is not empty.
            if marks.isEmpty {
                // `Marks` is emtpy.
                viewControllers?.remove(at: 0)
                tabBarController.selectedIndex = 1
                tabBarController.tabBar.items?[0].isEnabled = false
            } else if attendance.isEmpty {
                // `Attendance` is empty.
                viewControllers?.remove(at: 1)
                tabBarController.selectedIndex = 0
                tabBarController.tabBar.items?[1].isEnabled = false
            }
            // Move to Courses tab bar controller.
            self.present(tabBarController, animated: true, completion: nil)
        }
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
            self.data = data_dict["courses"] as! Array<[String: Any]>
        }
    }
}
