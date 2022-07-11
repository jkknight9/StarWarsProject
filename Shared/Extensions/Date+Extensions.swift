//
//  Date+Extensions.swift
//  StarWarsProject
//
//  Created by Jack Knight on 7/5/22.
//

import Foundation

extension Date {
    func formatDate(_ originalDate: String?) -> String {
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = originalDateFormatter.date(from: originalDate ?? "") else {return ""}
        originalDateFormatter.dateFormat = "MMM d, yyyy"
        let newDate = originalDateFormatter.string(from: date)
        return newDate
    }
}
