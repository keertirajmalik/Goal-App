//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Goal{
    var id = UUID()
    var task: String
    var completed: Bool
    
    mutating func updateCompleted(goalId: UUID){
        var goal = originalGoalsList.first(where: { goalId == $0.id})
        goal?.completed.toggle()
        print(goal)
    }
}

var originalGoalsList = [Goal(task: "Write an article or blogpost",completed: false),
             Goal(task: "Dribble Concept",completed: false),
             Goal(task: "Behance case study",completed: true),
             Goal(task: "Behance case study",completed: true),
             Goal(task: "Conduct exam",completed: true)]
