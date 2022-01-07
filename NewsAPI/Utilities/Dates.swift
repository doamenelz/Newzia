//
//  Dates.swift
//  NewsAPI
//
//  Created by Edem Ekeng on 2022-01-03.
//

import Foundation

class DateHelpers {
    
    static func formatFriendlyDate (date: Date, format: DateHelpersFormat) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = format.rawValue
        
        let stringFromDate = formatter.string(from: date)
        
        return stringFromDate
        
    }
    
    static func formatLastSignOnDate (date: String) -> String {
        
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let parsedServerDate = dateFormat.date(from: date)
        
        if parsedServerDate == nil {
            
            return "No Date Found"
            
        } else {
            
            let presentedDateFormatter = DateFormatter()
            
            presentedDateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
            
            let newDate = Calendar.current.dateComponents([.hour, .minute], from: parsedServerDate!, to: Date.now)
            
            if newDate.hour! >= 1 {
                
                return  "Published \(String(describing: newDate.hour!)) hours ago"
            } else {
                return "Published \(String(describing: newDate.minute!)) minutes ago"
                
            }
            
        }
        
        
        
    }
    
    static func formatToString (date: String) -> String {
        
        let fmt = ISO8601DateFormatter()
        
        
        let parsedServerDate = fmt.date(from: date)
        
        if parsedServerDate == nil {
            
            return "-"
            
        } else {
            
            let newDate = Calendar.current.dateComponents([.hour, .minute], from: parsedServerDate!, to: Date.now)
            
            if newDate.hour! >= 1 {
                
                return  "Published \(String(describing: newDate.hour!)) hours ago"
            } else {
                return "Published \(String(describing: newDate.minute!)) minutes ago"
                
            }
            
        }
        
        
        
    }
    
}


enum DateHelpersFormat : String {
    case monthYear = "MMM yyyy"
    case dayMonthYear = "dd MMM, yyyy"
    case weekday_full = "EEEE"
    case monthAlone = "MMMM"
    case month = "MMM"
    case monthYear_full = "MMMM yyyy"
    case weekDay_dayMonthYear = "EEEE, dd MMM yyyy"
    case dayMon = "EEE, dd MMM"
    case weekDayMon_short = "dd MMM"
}

/*
class DateHelper {
    
    static func changeRunDateToDate (date: String) -> Date {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        let parsedServerDate = dateFormat.date(from: date)
        return parsedServerDate!
        //let presentedDateFormatter = DateFormatter()
        
        
    }
    
    static func formatLastSignOnDate (date: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        let parsedServerDate = dateFormat.date(from: date)
        let presentedDateFormatter = DateFormatter()
        presentedDateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        
        let formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        
        return formattedDate
        
    }
    
    static func formatDateNormal (date: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let parsedServerDate = dateFormat.date(from: date)
        let presentedDateFormatter = DateFormatter()
        presentedDateFormatter.dateFormat = "MMM d, yyyy"
        
        print("parsed server date is \(parsedServerDate)")
        let formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        
        return formattedDate
        
    }
    
    static func formatDateExtraLong (date: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS+HH:mm"
        let parsedServerDate = dateFormat.date(from: date)
        let presentedDateFormatter = DateFormatter()
        presentedDateFormatter.dateFormat = "MMM d, yyyy"
        
        var formattedDate : String = ""
        
        if (parsedServerDate == nil) {
            formattedDate = "-"
        } else {
            formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        }
        
        
        return formattedDate
        
    }
    
    
    
    
    
    static func formatRunDate (date: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        let parsedServerDate = dateFormat.date(from: date)
        let presentedDateFormatter = DateFormatter()
        presentedDateFormatter.dateFormat = "dd MMMM, yyyy"
        
        let formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        
        return formattedDate
        
    }
    
    static func convertDateSlash (date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        
        let formattedDate = dateFormat.string(from: date)
        
        return formattedDate
        
    }
    
   static func calculateDateDifference (dateRangeType: StatementRangeOptions) -> Date {
        
        let today = DateHelper.changeRunDateToDate(date: RUN_DATE)
        
        var start : Date
        
        switch dateRangeType {
        case .last30:
            start = Calendar.current.date(byAdding: .day, value: -30, to: today)!
            return start
        case .last60:
            start = Calendar.current.date(byAdding: .day, value: -60, to: today)!
            return start
        case .last90:
            start = Calendar.current.date(byAdding: .day, value: -90, to: today)!
            return start
        default:
            return today
        }
    }
    
    static func convertDateToLong (date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, yyyy"
        
        let formattedDate = dateFormat.string(from: date)
        
        return formattedDate
        
    }
    
    static func convertDateToFull (date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd MMMM, yyyy"
        
        let formattedDate = dateFormat.string(from: date)
        
        return formattedDate
        
    }
}
*/


