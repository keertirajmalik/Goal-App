//
//  PersonalGoalsVCViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 26/07/22.
//

import UIKit

class PersonalGoalsViewController: UIViewController {
    @IBOutlet var goals: UITableView!
    @IBOutlet var addNewGoalButton: UIButton!
    var selectedSegmentIndex: Int = 0
    var goalList: [Goal]?
    var originalGoalsList: [Goal]?

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
        getGoalsList(segment: selectedSegmentIndex)
    }

    @IBAction func goalTypeChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        getGoalsList(segment: selectedSegmentIndex)
    }

    func getGoalsList(segment: Int) {
        if segment == 0 {
            goalList = originalGoalsList
            goals.reloadData()
        } else if segment == 1 {
            goalList = originalGoalsList?.filter { task in task.completed == false }
            goals.reloadData()
        } else if segment == 2 {
            goalList = originalGoalsList?.filter { task in
                task.goalDueDate < Date() && task.completed == false
            }
            goals.reloadData()
        } else if segment == 3 {
            goalList = originalGoalsList?.filter { task in task.completed == true }
            goals.reloadData()
        }
    }

    func updateActiveGoalCompletedStatus(id: String?) {
        if let id = id {
            if let index = originalGoalsList?.firstIndex(where: { $0.id == id }) {
                originalGoalsList?[index].updateGoalCompletedStatus()
                getGoalsList(segment: selectedSegmentIndex)
            } else {
                return
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "goToAddNewGoalStoryboard" {
            let controller = segue.destination as? AddNewGoalViewController
            controller?.originalGoalsList = originalGoalsList
        }
    }
}

extension PersonalGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        cell?.configureCell(selected: goalList?[indexPath.row].completed)
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
        cell.taskLabel.text = task?.task
        cell.configureCell(selected: task?.completed)
        return cell
    }
}
