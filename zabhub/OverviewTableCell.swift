//
//  OverviewTableCell.swift
//  zabhub
//
//  Created by ZabHub Team on 5/14/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import UIKit

class OverviewTableCell: UITableViewCell {

    @IBOutlet var lblCourseName: UILabel!
    @IBOutlet var lblTeacherName: UILabel!
    @IBOutlet var lblMarks: UILabel!
    @IBOutlet var lblAttendance: UILabel!
    @IBOutlet var lblSection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
