//
//  BaseTableViewController.swift
//  zabhub
//
//  Created by ZabHub Team on 6/3/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = Array<[String: Any]>()
    public var section_name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section_name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Override this function for on-row-click event.
    }
}
