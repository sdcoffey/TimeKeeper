//
//  Calendar.swift
//  TimeKeeper
//
//  Created by Coffey, Steven on 1/8/16.
//  Copyright © 2016 Braintree. All rights reserved.
//

import UIKit
import RealmSwift

class Calendar {
    
    static let SECOND = NSTimeInterval(1)
    static let MINUTE = 60 * SECOND
    static let HOUR = MINUTE * 60
    static let DAY = HOUR * 24
    
    private let realm = try! Realm()
    private let calendar = NSCalendar.currentCalendar()
    
    var today: NSDate {
        get {
            return NSDate()
        }
    }
    
    func eventsToday() -> Results<Event> {
        let todayStart = calendar.startOfDayForDate(today)
        let todayEnd = NSDate(timeInterval: Calendar.DAY, sinceDate: todayStart)
        
        let predicate = NSPredicate(format: "startTime > %@ OR endTime < %@", todayStart, todayEnd)
        return realm.objects(Event).filter(predicate).sorted("startTime")
    }
    
    func addEvent(event: Event) {
        try! realm.write {
            realm.add(event)
        }
    }
    
    func clear() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    class func eventsDuration(events: Results<Event>) -> NSTimeInterval {
        guard let end = events.last, begin = events.first else {
            return 0
        }
        
        return end.endTime.timeIntervalSinceDate(begin.startTime)
    }
}
