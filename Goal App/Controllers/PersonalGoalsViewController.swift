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
            originalGoals = await firestoreUtil.getGoals()
            getGoals(segment: selectedSegmentIndex)
        }
    }

    @IBAction func goalTypeChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        getGoals(segment: selectedSegmentIndex)
    }

    private func getGoals(segment: Int) {
        if segment == 0 {
            goalList = originalGoals
            goals.reloadData()
        } else if segment == 1 {
            goalList = originalGoals?.filter { task in task.completed == false }
            goals.reloadData()
        } else if segment == 2 {
            goalList = originalGoals?.filter { task in
                task.goalDueDate < Date() && task.completed == false
            }
            goals.reloadData()
        } else if segment == 3 {
            goalList = originalGoals?.filter { task in task.completed == true }
            goals.reloadData()
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "goToAddNewGoalStoryboard" {
            let controller = segue.destination as? AddNewGoalViewController
            controller?.originalGoals = originalGoals
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
