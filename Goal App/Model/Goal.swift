//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Goal {
    var id: String
    var task: String
    var completed: Bool
    var goalCreatedDate: Date
    var goalDueDate: Date

    mutating func updateGoalCompletedStatus() {
        completed.toggle()
    }
}

func stringToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
    return dateFormatter.date(from: dateString)!
}
