//
//  PersonalGoalsVCViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 26/07/22.
//

import UIKit

class PersonalGoalsViewController: UIViewController {
    @IBOutlet private var goals: UITableView!
    @IBOutlet private var addNewGoalButton: UIButton!
    private var selectedSegmentIndex: Int = 0
    private var goalList: [Goal]?
    var originalGoals: [Goal]?
    private let firestoreUtil = FirestoreService.shared
    private var goalFetchService: GoalDataFetch = GoalsDataFetchService()

    override func viewDidLoad() {
        super.viewDidLoad()

        goals.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goals.dataSource = self
        goals.delegate = self
        goals.showsVerticalScrollIndicator = false
        addNewGoalButton.layer.cornerRadius = addNewGoalButton.frame.width / 2
        addNewGoalButton.layer.masksToBounds = true
    }

    override func viewWillAppear(_: Bool) {
        Task {
            originalGoals = await goalFetchService.fetchAllGoals()
            getGoals(segment: selectedSegmentIndex)
        }
    }

    @IBAction func goalTypeChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        getGoals(segment: selectedSegmentIndex)
    }

    private func getGoals(segment: Int) {
        Task {
            if segment == 0 {
                goalList = await goalFetchService.fetchAllGoals()
                goals.reloadData()
            } else if segment == 1 {
                goalList = await goalFetchService.fetchActiveGoals()
                goals.reloadData()
            } else if segment == 2 {
                goalList = await goalFetchService.fetchOverDueGoals()
                goals.reloadData()
            } else if segment == 3 {
                goalList = await goalFetchService.fetchCompletedGoals()
                goals.reloadData()
            }
        }
    }

    private func updateActiveGoalCompletedStatus(id: String?) {
        if let id = id {
            if let index = originalGoals?.firstIndex(where: { $0.id == id }) {
                originalGoals?[index].updateGoalCompletedStatus()
                firestoreUtil.updateGoalsCompleteStatus(id: id, completed: originalGoals?[index].completed)
                getGoals(segment: selectedSegmentIndex)
            } else {
                return
            }
        }
    }
}

extension PersonalGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        cell?.configureCell(taskName: nil, selected: goalList?[indexPath.row].completed)
        updateActiveGoalCompletedStatus(id: goalList?[indexPath.row].id)
        goals.reloadData()
    }
}

extension PersonalGoalsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        goalList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let task = goalList?[indexPath.row]
        cell.configureCell(taskName: task?.task, selected: task?.completed)
        return cell
    }
}
