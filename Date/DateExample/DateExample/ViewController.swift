//
//  ViewController.swift
//  DateExample
//
//  Created by Pham Quang Huy on 6/7/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        testSplitDateRange()
        let dateUTC = convertToUTC(Date())
        print(dateUTC)
        
    }
    
    func testSplitDateRange() {
//        let dateString1 = "2018-06-14 00:00:00 +0000"
//        let dateString2 = "2018-08-22 00:00:00 +0000"
        let dateString1 = "2018-06-14"
        let dateString2 = "2018-08-22"
        let date1 = Date.convertStringToDate(fromString: dateString1, format: DateFormat.yyyyMMddDash)!
        let date2 = Date.convertStringToDate(fromString: dateString2, format: DateFormat.yyyyMMddDash)!
        
        let calendarComponents = self.splitDateRange(date1: date1, date2: date2)
        print(calendarComponents)
    }
    
    func splitDateRange(date1: Date, date2: Date) -> [(days: [Int], month: Int, year: Int)]{
        let dayBetween = Date.getBetweenDays(date1, endDate: date2)
        var ganttChartDateComponent = [(days: [Int], month: Int, year: Int)]()
        var arrDay = [Int]()
        var day = date1.getDay()!
        var month = date1.getMonth()
        var year = date1.getYear()
        var newDate = date1
        
        for i in 0..<dayBetween {
            if i == 0 {
                arrDay.append(day)
            } else if i == dayBetween - 1 {
                day = date2.getDay()!
                arrDay.append(day)
                
                ganttChartDateComponent.append((days: arrDay, month: month, year: year))
            } else {
                newDate = newDate.add(days: 1)
                
                if newDate.getMonth() != month {
                    
                    ganttChartDateComponent.append((days: arrDay, month: month, year: year))
                    
                    month = newDate.getMonth()
                    
                    if newDate.getYear() != year {
                        year = newDate.getYear()
                    }
                    
                    arrDay.removeAll()
                }
                
                day = newDate.getDay()!
                arrDay.append(day)
            }
        }
        
        return ganttChartDateComponent
    }
    
    func convertToUTC(_ date: Date) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddDash.rawValue
        var dateString = dateFormatter.string(from: date)
        print(dateString)
        
        dateString += " 17:00:00"
        
        dateFormatter.dateFormat = DateFormat.yyyyMMddMMhhss.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let newDate = dateFormatter.date(from: dateString)
        print(newDate!)
        return newDate!
    }
    
    func testLocalToUTC() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        let dateStringUTC = self.localToUTC(date: dateString)
        print(dateStringUTC)
    }
    
    func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
}

