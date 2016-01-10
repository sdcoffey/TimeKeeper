//
//  ViewController.swift
//  TimeKeeper
//
//  Created by Coffey, Steven on 1/8/16.
//  Copyright © 2016 Braintree. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var eventList: UICollectionView!
    private var events: Results<Event>!
    private var calendar: Calendar = Calendar()
    private static let collectionViewResuseId = "timeKeeperCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonHeight: CGFloat = 40
        let eventButton = newEventButton(CGRectMake(0, self.view.frame.size.height - buttonHeight, self.view.frame.size.width, buttonHeight))
        self.view.addSubview(eventButton)
        
        let eventListFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - buttonHeight)
        let layout = UICollectionViewFlowLayout()
        eventList = UICollectionView(frame: eventListFrame, collectionViewLayout: layout)
        eventList.delegate = self
        eventList.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ViewController.collectionViewResuseId)
        eventList.backgroundColor = UIColor(white: 0.98, alpha: 1)
        eventList.dataSource = self
        
        addFakeData()
        events = calendar.eventsToday()
        
        self.view.addSubview(eventList)
    }
    
    func addFakeData() {
        calendar.clear()
        
        let event = Event()
        event.endTime = NSDate()
        event.startTime = event.endTime.dateByAddingTimeInterval(-Calendar.HOUR)
        event.label = "Worked on TimeKeeper"
        
        let event2 = Event()
        event2.endTime = event.startTime
        event2.startTime = event2.endTime.dateByAddingTimeInterval(-Calendar.HOUR * 2)
        event2.label = "Youtube"
        
        calendar.addEvent(event)
        calendar.addEvent(event2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ViewController.collectionViewResuseId, forIndexPath: indexPath)
        let event = events[indexPath.row]
        
        let label = UILabel(frame: CGRectMake(0, 0, 100, 100))
        label.text = event.label
        label.sizeToFit()
        
        let size = sizeForEvent(event)
        label.frame = CGRectMake((size.width / 2) - (label.frame.size.width / 2), (size.height / 2) - (label.frame.size.height / 2), label.frame.size.width, label.frame.size.height)
        label.textColor = UIColor.whiteColor()
        
        cell.contentView.addSubview(label)
        
        let colorPercent = abs(Double(size.height / collectionView.frame.size.height) - 1.0)
        cell.backgroundColor = UIColor(red: 0.8, green: 0.129, blue: 0.129, alpha: CGFloat(colorPercent))
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return sizeForEvent(events[indexPath.row])
    }
    
    func sizeForEvent(event: Event) -> CGSize {
        let effectiveDuration = event.durationInDay(self.calendar.today)
        let height = eventList.frame.size.height * CGFloat(effectiveDuration / Calendar.DAY)
        return CGSizeMake(self.eventList.frame.size.width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func newEventButton(rect: CGRect) -> UIButton {
        let button = UIButton(frame: rect)
        button.titleLabel?.text = "New Task"
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: "addEventButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func addEventButtonTapped(sender: UIButton) {
    }
}

