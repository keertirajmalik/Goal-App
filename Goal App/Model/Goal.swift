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
    
    mutating func updateGoalCompletedStatus(){
        self.completed.toggle()
    }
}

var originalGoalsList = [Goal(id: UUID(), task: "Write an article or blogpost",completed: false),
                         Goal(id: UUID(), task: "Dribble Concept",completed: false),
                         Goal(id: UUID(), task: "Behance case study",completed: false),
                         Goal(id: UUID(), task: "Behance case study",completed: true),
                         Goal(id: UUID(), task: "Conduct exam",completed: false)]
