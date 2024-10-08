import Foundation

extension Date {
    
    func getInt(component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func getString(component: Calendar.Component, calendar: Calendar = Calendar.current) -> String {
        return String(calendar.component(component, from: self))
    }
    
    func getFormattedString(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) -> String {
        return Date().formatted(date: date, time: time)
    }
    
}
