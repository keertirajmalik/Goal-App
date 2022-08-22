//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Goal{
    var id: UUID
    var task: String
    var completed: Bool
    var goalCreatedDate: String
    var goalDueDate: String
    
    mutating func updateGoalCompletedStatus(){
        self.completed.toggle()
    }
}

var originalGoalsList = [Goal(id: UUID(), task: "Write an article or blogpost",completed: false, goalCreatedDate: "23-Aug-2022 12:05 AM", goalDueDate: "30-Aug-2022 12:05 AM"),
                         Goal(id: UUID(), task: "Dribble Concept",completed: false, goalCreatedDate: "23-Aug-2022 12:05 AM", goalDueDate: "30-Aug-2022 12:05 AM"),
                         Goal(id: UUID(), task: "Behance case study",completed: false, goalCreatedDate: "23-Aug-2022 12:05 AM", goalDueDate: "30-Aug-2022 12:05 AM"),
                         Goal(id: UUID(), task: "Behance case study",completed: true, goalCreatedDate: "23-Aug-2022 12:05 AM", goalDueDate: "30-Aug-2022 12:05 AM"),
                         Goal(id: UUID(), task: "Conduct exam",completed: false, goalCreatedDate: "23-Aug-2022 12:05 AM", goalDueDate: "30-Aug-2022 12:05 AM")]

