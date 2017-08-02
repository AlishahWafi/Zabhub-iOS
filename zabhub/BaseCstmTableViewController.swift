//
//  BaseCustomTableViewController.swift
//  zabhub
//
//  Created by Ammar Ahmad on 6/1/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class BaseCstmTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tblView: UITableView!
    let preferences = UserDefaults.standard
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


}
