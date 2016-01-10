//
//  Event.swift
//  TimeKeeper
//
//  Created by Coffey, Steven on 1/8/16.
//  Copyright © 2016 Braintree. All rights reserved.
//

import UIKit
import RealmSwift

class Event: Object {
    dynamic var startTime: NSDate!
    dynamic var label: String = ""
    dynamic var endTime: NSDate!
    
    var duration: NSTimeInterval {
        get {
            return endTime.timeIntervalSinceDate(startTime)
        }
    }
    
    func durationInDay(day: NSDate) -> NSTimeInterval {
        let calendar = NSCalendar.currentCalendar()
        let comparisonResult = calendar.compareDate(startTime, toDate: endTime, toUnitGranularity: NSCalendarUnit.Day)
        if comparisonResult == NSComparisonResult.OrderedAscending {
            let start = calendar.startOfDayForDate(day)
            return endTime.timeIntervalSinceDate(start)
        } else if comparisonResult == NSComparisonResult.OrderedDescending {
            let end = calendar.startOfDayForDate(day).dateByAddingTimeInterval(Calendar.DAY)
            return end.timeIntervalSinceDate(startTime)
        } else {
            return endTime.timeIntervalSinceDate(startTime)
        }
    }
}

