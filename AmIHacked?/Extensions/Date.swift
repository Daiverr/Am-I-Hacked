//
//  Date.swift
//  AmIHacked?
//
//  Created by PROKHOROV Roman on 25.08.2023.
//

import Foundation

extension Date {
    static let current: Self = {
        .init()
    }()

    static let formatter = DateFormatter()
    
    func toString(
        _ dateFormatter: DateFormatter = formatter,
        format: DateFormat = .dashedShort
    ) -> String {
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Moscow")
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}

enum DateFormat: String {
    case defaultHistory = "yyyy-MM-dd'T'HH:mm"
    case dashedShort = "yyyy-MM-dd"
    case pointedShort = "dd.MM.yyyy"
    case iso8601Full = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case dayMonth = "d MMMM"
    case dayShortMonth = "d MMM"
    case dayMonthTime = "d MMMM, HH:mm"
    case dayMonthWeekdayTime = "d MMMM, EEEE, HH:mm"
    case monthYear = "MM.yyyy"
    case dateKey = "d MMMM, E"
    case dateTitle = "dd MMMM, E"
    case dateShortTitleWeekday = "d MMMM, EEEE"
    case dateShortTitleWithYear = "d MMMM yyyy"
    case dateTitleWithYear = "dd MMMM yyyy"
    case dateSectionTitle = "LLLL yyyy"
    case dateSectionTitleShortMonth = "MMM yyyy"
    case dateSectionTitleWithoutYear = "LLLL"
}

