//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Goal{
    var task: String
    var completed: Bool
    
    mutating func updateCompleted(){
        self.completed.toggle()
    }
}

var originalGoalsList = [Goal(task: "Write an article or blogpost",completed: false),
             Goal(task: "Dribble Concept",completed: false),
             Goal(task: "Behance case study",completed: false),
             Goal(task: "Behance case study",completed: true),
             Goal(task: "Conduct exam",completed: false)]
