//
//  DatePickerView.swift
//  Jooto
//
//  Created by Huy Pham Quang on 8/4/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

enum DatePickerMode: Int {
    case time
    case yearAndMonth
    case yearOnly
    case monthOnly
    case dayOnly
    case other
    case japaneseDate
    case yearMonthDayJP
    case dayMonthYearEn
}

class DatePickerInputView: UIView {
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!

    // Actions
    private var selectDoneAction: ((_ result: Any?) -> Void)?
    private var months: [String] = []
    private var years: [String] = []
    private var days: [String] = []
    private var dates: [String] = []
    private var times: [String] = []

    var datePickerMode = DatePickerMode.time
    var startYear = 1970 // using for YearMonth mode
    var numberOfMonth = 12 // using for YearMonth mode
    var numberOfDay = 31

    var yearSelected: Int = 0 {
        didSet {
            if self.datePickerMode == .dayMonthYearEn {
                self.pickerView.selectRow(self.years.firstIndex(of: "\(self.yearSelected)") ?? 0, inComponent: 2, animated: true)
            } else {
                self.pickerView.selectRow(self.years.firstIndex(of: "\(self.yearSelected)") ?? 0, inComponent: 0, animated: true)
            }
        }
    }

    var monthSelected: Int = 0 {
        didSet {
            if self.datePickerMode == .monthOnly {
                self.pickerView.selectRow(self.monthSelected, inComponent: 0, animated: false)
            } else if self.datePickerMode == .yearMonthDayJP {
                self.pickerView.selectRow(self.months.firstIndex(of: "\(self.monthSelected)") ?? 0, inComponent: 1, animated: true)
            } else if self.datePickerMode == .dayMonthYearEn {
                self.pickerView.selectRow(self.months.firstIndex(of: "\(self.monthSelected)") ?? 0, inComponent: 1, animated: true)
            } else {
                self.pickerView.selectRow(self.monthSelected - 1, inComponent: 1, animated: false)
            }

        }
    }

    var daySelected: Int = 0 {
        didSet {
            if self.datePickerMode == .dayOnly {
                self.pickerView.selectRow(self.daySelected, inComponent: 0, animated: true)
            } else if self.datePickerMode == .dayMonthYearEn {
                self.pickerView.selectRow(self.days.firstIndex(of: "\(self.daySelected)") ?? 0, inComponent: 0, animated: true)
            } else {
                self.pickerView.selectRow(self.days.firstIndex(of: "\(self.daySelected)") ?? 0, inComponent: 2, animated: true)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }

    func setModeDatePicker(datePickerMode:DatePickerMode, yearSelected: Int? = nil, monthSelected: Int? = nil) {
        self.datePickerMode = datePickerMode

        if datePickerMode == DatePickerMode.yearAndMonth {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true

            // setup
            self.setupYearMonthPicker()
        } else if self.datePickerMode == DatePickerMode.yearOnly {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true

            // setup
            self.setupYearPicker()
        } else if self.datePickerMode == DatePickerMode.monthOnly {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true

            // setup
            self.setupMonthPicker()
        } else if self.datePickerMode == DatePickerMode.dayOnly {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true

            // setup
            self.setupDayPicker(YearSelected: yearSelected, MonthSelected: monthSelected)
        } else if datePickerMode == .yearMonthDayJP {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true
            // data
            self.setupDayMonthYearData()
        } else if datePickerMode == .dayMonthYearEn {
            self.pickerView.isHidden = false
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.datePicker.isHidden = true
            // data
            self.setupDayMonthYearData()
        } else if datePickerMode == DatePickerMode.japaneseDate {
            self.pickerView.isHidden = true
            self.pickerView.delegate = nil
            self.pickerView.dataSource = nil
            self.datePicker.isHidden = false

            // set locale
            self.datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        } else {
            self.pickerView.isHidden = true
            self.pickerView.delegate = nil
            self.pickerView.dataSource = nil
            self.datePicker.isHidden = false
        }
    }

    // MARK: Setup Data
    func setupYearMonthPicker() {
        // population years
        var years: [String] = []
        let currentYear = Calendar(identifier: .gregorian).component(.year, from: Date())

        if years.count == 0 {
            for index in (startYear...currentYear + 2).reversed() {
                years.append("\(index)")
            }
        }

        self.years = years

        // population months with localized names
        var months: [String] = []

        for month in 0...numberOfMonth - 1 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
        }

        self.months = months

        // set curent value
        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        self.monthSelected = currentMonth
        self.yearSelected = currentYear
    }

    func setupYearPicker() {
        // population years
        var years: [String] = []
        let year = Calendar(identifier: .gregorian).component(.year, from: Date())

        if years.count == 0 {
            for index in (startYear...year).reversed() {
                years.append("\(index)")
            }
        }

        self.years = years
    }

    func setupMonthPicker() {
        // population months with localized names
        var months: [String] = []

        for month in 0...numberOfMonth - 1 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
        }
        months.insert("", at: 0)
        self.months = months

        // set curent value
        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        self.monthSelected = currentMonth
    }

    func setupDayPicker(YearSelected year: Int?, MonthSelected month: Int?) {
        let days = self.numberOfDayinMonth(year, month: month)
        self.days = days

        // set curent value
        let currentDay = Calendar(identifier: .gregorian).component(.day, from: Date())
        self.daySelected = currentDay
    }

    func setupDayMonthYearData() {
        // setup year
        var years: [String] = []
        let yearNow = Calendar(identifier: .gregorian).component(.year, from: Date())

        if years.count == 0 {
            for index in (1916...yearNow).reversed() {
                years.append("\(index)")
            }
        }

        self.years = years

        // setup month
        var months: [String] = []

        for index in 1...self.numberOfMonth {
            months.append("\(index)")
        }

        self.months = months

        // setup day
        var days: [String] = []

        for index in 1...self.numberOfDay {
            days.append("\(index)")
        }

        self.days = days
    }

    // MARK: - View
    func initView()  {

    }

    static func instanceFromNib() -> DatePickerInputView? {
        return UINib(nibName: "DatePickerInputView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? DatePickerInputView
    }

    // MARK: IBActions
    @IBAction func btnClearPressed(_ sender: Any) {

    }

    @IBAction func btnDonePressed(_ sender: Any) {

    }

    // MARK: - Add Actions
    func addSelectDoneAction(completion: @escaping (_ result:Any?) -> Void) {
        self.selectDoneAction = completion
    }

    func numberOfDayinMonth(_ year: Int?, month: Int?) -> [String] {
        if let year = year, let month = month {
            return isLeapYear(year, month: month)
        } else {
            return isLeapYear(self.yearSelected, month: self.monthSelected)
        }
    }

    func isLeapYear(_ year: Int, month: Int) -> [String] {
        if (year % 4 == 0 && month == 2) || (year % 400 == 0 && year % 100 == 0 && month == 2) {
            return addElementToMinMaxValue(min: 1, max: 29)
        } else if month == 2 {
            return addElementToMinMaxValue(min: 1, max: 28)
        } else {
            return addElementToMinMaxValue(min: 1, max: self.getDaysInMonth(month, year: year))
        }
    }

    func addElementToMinMaxValue(min: Int, max: Int) -> [String] {
        var result = [String]()

        if result.isEmpty {
            for item in (min...max) {
                result.append("\(item)")
            }
        }

        return result
    }

    func getDaysInMonth(_ month: Int, year: Int) -> Int {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        let calendar = NSCalendar.current
        let date = calendar.date(from: dateComponents as DateComponents)//.dateComponents(dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date!)
        return (range?.count)!//rangeOfUnit(.Day, inUnit: .Month, forDate: date).length
    }

    func dateSelectedToString() -> String {
        let yearShow = self.yearSelected != 0 ? "\(self.yearSelected)" : "0000"
        var monthShow: String

        if self.monthSelected < 1 {
            monthShow = "00"
        } else if self.monthSelected > 9 {
            monthShow = "\(self.monthSelected)"
        } else {
            monthShow = "0\(self.monthSelected)"
        }

        var dayShow: String
        
        if self.daySelected < 1 {
            dayShow = "00"
        } else if self.daySelected > 9 {
            dayShow = "\(self.daySelected)"
        } else {
            dayShow = "0\(self.daySelected)"
        }

        return "\(yearShow)-\(monthShow)-\(dayShow)"
    }
}

// MARK: UIPickerViewDataSource
extension DatePickerInputView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.datePickerMode == .yearOnly || self.datePickerMode == .monthOnly || self.datePickerMode == .dayOnly {
            return 1
        } else if self.datePickerMode == .dayMonthYearEn || self.datePickerMode == .yearMonthDayJP {
            return 3
        } else {
            return 2
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if self.datePickerMode == .yearOnly {
                return "\(self.years[row])"
            } else if self.datePickerMode == .monthOnly {
                return self.months[row]
            } else if self.datePickerMode == .dayOnly {
                return self.days[row]
            } else if self.datePickerMode == .dayMonthYearEn {
                return self.days[row]
            } else if self.datePickerMode == .yearMonthDayJP {
                return "\(self.years[row])年"
            } else {
                return "\(self.years[row])"
            }
        case 1:
            if self.datePickerMode == .yearMonthDayJP {
                return self.months[row] + "月"
            } else {
                return self.months[row]
            }
        case 2:
            if self.datePickerMode == .dayMonthYearEn {
                return self.years[row]
            } else if self.datePickerMode == .yearMonthDayJP {
                return self.days[row] + "日"
            } else {
                return self.days[row]
            }
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            if self.datePickerMode == .yearOnly {
                return self.years.count
            } else if self.datePickerMode == .monthOnly {
                return self.months.count
            } else if self.datePickerMode == .dayOnly {
                return self.days.count
            } else if self.datePickerMode == .dayMonthYearEn {
                return self.days.count
            } else {
                return self.years.count
            }
        case 1:
            return self.months.count
        case 2:
            if self.datePickerMode == .dayMonthYearEn {
                return self.years.count
            } else {
                return self.days.count
            }
        default:
            return 0
        }
    }
}

// MARK: UIPickerViewDelegate
extension DatePickerInputView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.datePickerMode == .yearOnly {
            let year = self.years[self.pickerView.selectedRow(inComponent: 0)]
            self.yearSelected = (year == "") ? 0 : Int(year)!
        } else if self.datePickerMode == .monthOnly {
            let month = self.pickerView.selectedRow(inComponent: 0)
            self.monthSelected = month
        } else if self.datePickerMode == .dayOnly {
            let day = self.pickerView.selectedRow(inComponent: 0)
            self.daySelected = day
        } else if self.datePickerMode == .yearMonthDayJP {
            let year = self.years[self.pickerView.selectedRow(inComponent: 0)]
            let month = self.months[self.pickerView.selectedRow(inComponent: 1)]
            let day = self.days[self.pickerView.selectedRow(inComponent: 2)]

            if component == 0 {
//                self.setMonthOfPickerView(yearSelected: year, monthSelected: "\(self.monthSelected)")
                self.setDayOfPickerView(yearSelected: year, monthSelected: "\(self.monthSelected)", daySelected: "\(self.daySelected)")
            } else if component == 1 {
                self.monthSelected = Int(month)!
                self.setDayOfPickerView(yearSelected: "\(self.yearSelected)", monthSelected: "\(self.monthSelected)", daySelected: "\(self.daySelected)")
            } else if component == 2 {
                self.daySelected = Int(day)!
            }
        } else if self.datePickerMode == .dayMonthYearEn {
            let year = self.years[self.pickerView.selectedRow(inComponent: 2)]
            let month = self.months[self.pickerView.selectedRow(inComponent: 1)]
            let day = self.days[self.pickerView.selectedRow(inComponent: 0)]

            if component == 2 {
//                self.setMonthOfPickerView(yearSelected: year, monthSelected: "\(self.monthSelected)")
                self.setDayOfPickerView(yearSelected: year, monthSelected: "\(self.monthSelected)", daySelected: "\(self.daySelected)")
            } else if component == 1 {
                self.monthSelected = Int(month)!
                self.setDayOfPickerView(yearSelected: "\(self.yearSelected)", monthSelected: "\(self.monthSelected)", daySelected: "\(self.daySelected)")
            } else if component == 0 {
                self.daySelected = Int(day)!
            }
        } else {
            let month = self.pickerView.selectedRow(inComponent: 1) + 1
            let year = self.years[self.pickerView.selectedRow(inComponent: 0)]
            self.monthSelected = month
            self.yearSelected = (year == "") ? 0 : Int(year)!
        }

    }

    func setMonthOfPickerView(yearSelected: String, monthSelected: String) {
        let currentYearNow = Calendar(identifier: .gregorian).component(.year, from: Date())
        let currentMonthNow = Calendar(identifier: .gregorian).component(.month, from: Date())

        var months: [String] = []
        let maxMonth = yearSelected == "\(currentYearNow)" ? currentMonthNow : 12

        for index in 1...maxMonth {
            months.append("\(index)")
        }

        self.months = months

        if Int(monthSelected)! > maxMonth && monthSelected != "0" {
            self.pickerView.reloadComponent(1)
            self.monthSelected = currentMonthNow
        } else if Int(monthSelected)! <= maxMonth && monthSelected != "0" {
            self.pickerView.reloadComponent(1)
            self.monthSelected = Int(monthSelected)!
        } else {
            pickerView.reloadComponent(1)
            self.monthSelected = Int(monthSelected)!
        }

        self.yearSelected = Int(yearSelected)!

    }

    func setDayOfPickerView(yearSelected: String, monthSelected: String, daySelected: String) {
        let currentYearNow = Calendar(identifier: .gregorian).component(.year, from: Date())
        let currentMonthNow = Calendar(identifier: .gregorian).component(.month, from: Date())
        let currentDayNow = Calendar(identifier: .gregorian).component(.day, from: Date())

        var days: [String] = []
        var maxDay: Int

        if yearSelected == "\(currentYearNow)" && monthSelected == "\(currentMonthNow)" {
            maxDay = currentDayNow
        } else {
            maxDay = Int(self.numberOfDayinMonth(Int(yearSelected), month: Int(monthSelected)).last!)!
        }

        for index in (1...maxDay) {
            days.append("\(index)")
        }

        self.days = days

        if self.datePickerMode == .dayMonthYearEn {
            self.pickerView.reloadComponent(0)
        } else {
            self.pickerView.reloadComponent(2)
        }

        if Int(daySelected)! > maxDay && daySelected != "0"{
            self.daySelected = maxDay
        } else if Int(daySelected)! <= maxDay && daySelected != "0"{
            self.daySelected = Int(daySelected)!
        } else {
            self.daySelected = Int(daySelected)!
        }

    }
}
