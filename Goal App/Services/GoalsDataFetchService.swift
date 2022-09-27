//
//  GoalsDataFetchService.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 25/09/22.
//

import Foundation

protocol GoalDataFetch {
    func fetchAllGoals() async -> [Goal]?
    func fetchCompletedGoals() async -> [Goal]?
    func fetchOverDueGoals() async -> [Goal]?
    func fetchActiveGoals() async -> [Goal]?
    func completionRateCalculator(originalGoals: [Goal]?) -> Float
    func overDueRateCalculator(originalGoals: [Goal]?) -> Float
    func updateGoalsCompleteStatus(id: String?, completed: Bool?)
    func accuracyRateCalculator(originalGoals: [Goal]?) -> Float
}

class GoalsDataFetchService: GoalDataFetch {
    var originalGoals: [Goal]?
    let firestoreUtil = FirestoreService.shared

    func fetchAllGoals() async -> [Goal]? {
        originalGoals = await firestoreUtil.getGoals()
        return originalGoals
    }

    func fetchActiveGoals() async -> [Goal]? {
        originalGoals = await fetchAllGoals()
        return originalGoals?.filter { task in task.completed == false }
    }

    func fetchCompletedGoals() async -> [Goal]? {
        originalGoals = await fetchAllGoals()
        return originalGoals?.filter { task in task.completed == true }
    }

    func fetchOverDueGoals() async -> [Goal]? {
        originalGoals = await fetchAllGoals()
        return originalGoals?.filter { task in
            task.goalDueDate > Date() && task.completed == false
        }
    }

    func completionRateCalculator(originalGoals: [Goal]?) -> Float {
        let completedTaskCount = originalGoals?.filter { task in task.completed == true }.count
        let totoalTaskCount = originalGoals?.count
        if totoalTaskCount == 0 {
            return 0
        }
        return Float(completedTaskCount ?? 0) / Float(totoalTaskCount ?? 0)
    }

    func overDueRateCalculator(originalGoals: [Goal]?) -> Float {
        let overdueGoalCount = originalGoals?.filter { task in
            task.goalDueDate > Date() && task.completed == false
        }.count
        let totoalGoalCount = originalGoals?.count
        if totoalGoalCount == 0 {
            return 0
        }
        return Float(overdueGoalCount ?? 0) / Float(totoalGoalCount ?? 0)
    }

    func accuracyRateCalculator(originalGoals: [Goal]?) -> Float {
        let overdueGoalCount = originalGoals?.filter { task in
            task.goalDueDate > Date() && task.completed == false
        }.count ?? 0
        let completedGoalCount = originalGoals?.filter { task in task.completed == true }.count ?? 0
        let totoalGoalCount = originalGoals?.count ?? 0
        if totoalGoalCount == 0 {
            return 0
        }
        return Float(completedGoalCount - overdueGoalCount) / Float(totoalGoalCount)
    }

    func updateGoalsCompleteStatus(id: String?, completed: Bool?) {
        firestoreUtil.updateGoalsCompleteStatus(id: id, completed: completed)
    }
}
