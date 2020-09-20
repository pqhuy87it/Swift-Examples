//
//  Date+Extension.swift
//  DateExample
//
//  Created by Pham Quang Huy on 6/8/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case yyyyssDash = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddDash = "yyyy-MM-dd"
    case yyyyssSSSZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case yyyyssZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case yyyyMMddJp = "yyyy年MM月d日"
    case yyyyMMddSSJp = "yyyy年MM月d日 HH:mm"
    case yyyyssSSSZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddMMyyyyDash = "dd-MM-yyyy"
    case yyyyMMddSpace = "yyyy MM dd"
    case yyyyMMddSlash = "yyyy/MM/dd"
    case yyyyMMddhhMMssZ = "YYYY-MM-dd hh:mm:ss +0000"
    case yyyyMMddMMhhss = "yyyy-MM-dd HH:mm:ss"
}

enum LocaleIdentifier: String {
    case enUSPOSIX = "en_US_POSIX"
}

extension Date {
    /// Returns a Date with the specified days added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }
    
    func getDay() -> Int? {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    func getMonth() -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    func getYear() -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    static func getBetweenDays(_ startDate: Date, endDate: Date) -> Int {
        let calendar: Calendar = Calendar.current
        return (calendar as NSCalendar).components(NSCalendar.Unit.day, from: startDate, to: endDate, options: []).day!
    }
    
    static func convertStringToDate(fromString: String?, format: DateFormat) -> Date? {
        if let dateString = fromString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "UTC")//TimeZone(abbreviation: "GMT+0:00")//NSTimeZone.default
            dateFormatter.locale = NSLocale(localeIdentifier: LocaleIdentifier.enUSPOSIX.rawValue) as Locale?
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.date(from: dateString)
        } else {
            return nil
        }
    }
}
