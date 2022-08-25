//
//  PersonalGoalsVCViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 26/07/22.
//

import UIKit

class PersonalGoalsViewController: UIViewController {
    
    @IBOutlet weak var goals: UITableView!
    @IBOutlet weak var addNewGoalButton: UIButton!
    var selectedSegmentIndex: Int = 0
    var goalList: [Goal] = originalGoalsList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goals.dataSource = self
        goals.delegate = self
        goals.showsVerticalScrollIndicator = false
        addNewGoalButton.layer.cornerRadius = addNewGoalButton.frame.width / 2
        addNewGoalButton.layer.masksToBounds = true
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
            goalList = originalGoalsList.filter { task in task.completed == false }
            goals.reloadData()
        } else if segment == 2 {
            goalList = originalGoalsList.filter { task in task.completed == true }
            goals.reloadData()
        }
    }
    
    func updateActiveGoalCompletedStatus(id: UUID) {
        originalGoalsList[originalGoalsList.firstIndex(where: {$0.id == id})!].updateGoalCompletedStatus()
        getGoalsList(segment: selectedSegmentIndex)
    }
}

extension PersonalGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        cell?.configureCell(selected: goalList[indexPath.row].completed)
        updateActiveGoalCompletedStatus(id: goalList[indexPath.row].id)
        goals.reloadData()
    }
}

extension PersonalGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        let task = goalList[indexPath.row]
        cell?.taskLabel.text = task.task
        cell?.configureCell(selected: task.completed)
        return cell!
    }
}
