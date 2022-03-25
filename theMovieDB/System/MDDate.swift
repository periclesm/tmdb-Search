//
//  MDDate.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

enum DateFormat: String {
	case original = "yyyy-MM-dd" //2022-01-02 -- Used in API query parameter
	case formatted = "dd/MM/yyyy" //02/01/2022 -- Used to display date in Detail
	case short = "yyyy" //2022 -- Used to display date in cell
}

class MDDate: NSObject {
	static var shared = MDDate()
	private var formatter = DateFormatter()
	
	override init() {
		formatter.locale = Locale.current
		formatter.calendar = Calendar.current
		formatter.timeZone = TimeZone.current
	}
	
	func convertStringToDate(dateString: String?, format: DateFormat) -> Date {
		guard let stringDate = dateString else {
			return Date()
		}
		
		self.formatter.dateFormat = format.rawValue
		
		if let date = formatter.date(from: stringDate) {
			return date
		}
		else {
			return Date()
		}
	}
	
	func convertDateToString(date: Date?, format: DateFormat) -> String {
		if let inputDate = date {
			self.formatter.dateFormat = format.rawValue
			return formatter.string(from: inputDate)
		}
		else {
			self.formatter.dateFormat = format.rawValue
			return formatter.string(from: Date())
		}
	}
	
	func convertDateFormat(inputString: String?, fromFormat: DateFormat, toFormat: DateFormat) -> String {
		guard let inputDate = inputString else {
			return "2020-01-01"
		}
		
		let date = self.convertStringToDate(dateString: inputDate, format: fromFormat)
		return self.convertDateToString(date: date, format: toFormat)
	}
}
