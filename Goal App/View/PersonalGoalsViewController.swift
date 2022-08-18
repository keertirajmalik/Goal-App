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
    
    var goalList: [Goal] = originalGoalsList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goals.dataSource = self
        goals.delegate = self
        
        addNewGoalButton.layer.cornerRadius = addNewGoalButton.frame.width / 2
        addNewGoalButton.layer.masksToBounds = true
    }
    
    
    @IBAction func goalTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            goalList = originalGoalsList
            goals.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            goalList = originalGoalsList.filter { task in task.completed == false }
            goals.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            goalList = originalGoalsList.filter { task in task.completed == true }
            goals.reloadData()
        }
    }
    
    
}

extension PersonalGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell

//        var goal = originalGoalsList.first(where: { goalList[indexPath.row].id == $0.id})
//        goal?.completed.toggle()
        goalList[indexPath.row].completed.toggle()
//        print(originalGoalsList)
        
        updateCompleted(goalId: goalList[indexPath.row].id)
        print(originalGoalsList)

        cell.configureCell(selected:  goalList[indexPath.row].completed)
        goals.reloadData()
    }
    
    func updateCompleted(goalId: UUID) -> [Goal]{
        var goal = originalGoalsList.first(where: { goalId == $0.id})?.completed
       return goal?.toggle()
        
        
//        print(goal)[
    }
}

//extension PersonalGoalsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//        goalList[indexPath.row].completed.toggle()
//        originalGoalsList[indexPath.row].completed.toggle()
//        cell.configureCell(selected: goalList[indexPath.row].completed)
//    }
//}

extension PersonalGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let task = goalList[indexPath.row]
        cell.taskLabel.text = task.task
        cell.configureCell(selected: task.completed)
        return cell
    }
}
