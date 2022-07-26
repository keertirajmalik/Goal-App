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
    
    var taskList: [Task] = tasks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        goals.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goals.dataSource = self
        goals.delegate = self
        
        addNewGoalButton.layer.cornerRadius = addNewGoalButton.frame.width / 2
        addNewGoalButton.layer.masksToBounds = true
    }
    
    
    @IBAction func goalTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            taskList = tasks
            goals.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            taskList = tasks.filter { task in task.completed == false }
            goals.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            taskList = tasks.filter { task in task.completed == true }
            goals.reloadData()
        }
    }
}

extension PersonalGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        tasks[indexPath.row].completed.toggle()
        taskList[indexPath.row].completed.toggle()
        cell.configureCell(selected: taskList[indexPath.row].completed)
    }
}

extension PersonalGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let task = taskList[indexPath.row]
        cell.taskLabel.text = task.task
        cell.configureCell(selected: task.completed)
        return cell
    }
}
