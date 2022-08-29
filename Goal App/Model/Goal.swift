//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Goal {
    var id: UUID
    var task: String
    var completed: Bool
    var goalCreatedDate: Date
    var goalDueDate: Date

    mutating func updateGoalCompletedStatus() {
        completed.toggle()
    }
}

// swiftlint:disable all
var originalGoalsList: [Goal] = [
    Goal(id: UUID(), task: "Buy More milk", completed: false, goalCreatedDate: Date(), goalDueDate: stringToDate(dateString: "2022-08-24T16:54:09+0000")),
    Goal(id: UUID(), task: "Buy Eggs", completed: false, goalCreatedDate: stringToDate(dateString: "2022-08-23T16:54:09+0000"), goalDueDate: stringToDate(dateString: "2023-08-31T16:54:09+0000")),
    Goal(id: UUID(), task: "Read a book", completed: false, goalCreatedDate: stringToDate(dateString: "2022-08-23T16:54:20+0000"), goalDueDate: stringToDate(dateString: "2023-08-31T16:54:00+0000")),
]
// swiftlint:enable all

func stringToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
    return dateFormatter.date(from: dateString)!
}
