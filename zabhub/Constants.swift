//
//  Constants.swift
//  zabhub
//
//  Created by ZabHub Team on 5/13/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import Foundation
import SwiftDate

class Constants {
    static let SECURITY_USERNAME_KEY = "USERNAME"
    static let SECURITY_PASSWORD_KEY = "PASSWORD"
    static let PROFILE_LAST_SYNC_DATETIME_KEY = "PLSDTK"
    
    static let TIMEZONE = Region(
        tz: TimeZoneName.asiaKarachi,
        cal: CalendarName.gregorian,
        loc: LocaleName.englishPakistan)
    
    static let TOKEN: String = "1d516164-7f3d-408f-bed9-8ed1b4ef325a"
    static let BASE_URL: String = "http://39.44.38.249:8090/"
    static let BASE_API_URL: String = BASE_URL + "api/"
    static let ZABHUB_WEB_FORGOT_URL: String = BASE_URL + "forgot/"
    
    static let END_POINTS: [String: String] = [
        "login": "login",
        "register": "register",
        "profile": "profile",
        "resync": "resync",
        "semesters": "semesters",
        "courses": "courses",
        "marks": "marks",
        "attendance": "attendance",
        "outline": "outline",
        "files": "files"
    ]
    
    static func getAbsUrl(key: String) -> String {
        return self.BASE_API_URL + self.END_POINTS[key]!
    }
}
