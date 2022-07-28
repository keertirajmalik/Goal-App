//
//  Task.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/07/22.
//

import Foundation

struct Task{
    var task: String
    var completed: Bool
}

var tasks = [Task(task: "Write an article or blogpost",completed: false),
             Task(task: "Dribble Concept",completed: false),
             Task(task: "Behance case study",completed: true),
             Task(task: "Behance case study",completed: true),
             Task(task: "Conduct exam",completed: true)]
