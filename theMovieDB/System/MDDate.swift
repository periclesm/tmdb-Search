//
//  MDDate.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

enum DateFormat: String {
	case original = "yyyy-MM-dd" //`2022-01-02` -- Date format as it comes from TMDB
	case formatted = "dd/MM/yyyy" //`02/01/2022` -- Used to display date in Movie Details
	case short = "yyyy" //`2022` -- Used to display date in search list cell
}

class MDDate: NSObject {
	
	///A shared instance object for the formatter to be available whenever needed from any caller.
	static var shared = MDDate()
	
	///The Date formatter
	private var formatter = DateFormatter()
	
	override init() {
		formatter.locale = Locale.current
		formatter.calendar = Calendar.current
		formatter.timeZone = TimeZone.current
	}
	
	///Converts a date string into a Date object.
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
	
	///Converts a Date object into a string.
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
	
	///Converts a date string from one format into another.
	func convertDateFormat(inputString: String?, fromFormat: DateFormat, toFormat: DateFormat) -> String {
		guard let inputDate = inputString else {
			return "2020-01-01"
		}
		
		let date = self.convertStringToDate(dateString: inputDate, format: fromFormat)
		return self.convertDateToString(date: date, format: toFormat)
	}
}
