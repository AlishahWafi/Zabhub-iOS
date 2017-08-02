//
//  Strings.swift
//  zabhub
//
//  Created by ZabHub Team on 5/15/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import Foundation
import SwiftDate


class Strings {
    static func dictToArray(inData: [String: Any]) -> Array<[String: Any]> {
        var outData = Array<[String: Any]>()
        for (key, value) in inData {
            outData.append([key: value])
        }
        return outData
    }
    
    static func strToDateInRegion(dateString: String) -> DateInRegion {
        return DateInRegion(
            string: dateString,
            format: .iso8601(options: .withInternetDateTime),
            fromRegion: Constants.TIMEZONE
        )!
    }
    
    static func getNaturalTime(dateString: String) -> String {
        let finish_datetime = Strings.strToDateInRegion(dateString: dateString)
        let (natural_time, _) = try! finish_datetime.colloquialSinceNow()
        return natural_time
    }
}
