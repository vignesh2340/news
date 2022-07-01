//
//  DateTimeUtils.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

class DateTimeUtils: NSObject {
    //MARK:- Get News time
    static func getNewsTime(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"

        if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26") {
            return dateFormatterPrint.string(from: date)
        }
        
        return ""
    }
}
