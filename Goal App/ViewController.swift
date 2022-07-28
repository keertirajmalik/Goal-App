//
//  ViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 09/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var overDueProgress: CircularProgressView!
    @IBOutlet weak var overDueProgressPercetange: UILabel!
    @IBOutlet weak var completionRateProgress: CircularProgressView!
    @IBOutlet weak var completionRateProgressPercentage: UILabel!
    @IBOutlet weak var accuracyProgress: CircularProgressView!
    @IBOutlet weak var accuracyProgressPercentage: UILabel!
    
    @IBOutlet weak var goalTasks: UITableView!
    
    var activeGoals: [Task] = tasks.filter { task in task.completed == false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressCircleSetup()
        goalTasks.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goalTasks.dataSource = self
        goalTasks.delegate = self
    }
    
    private func progressCircleSetup(){
        let activityPercetage = Float(0.60)
        overDueProgress.trackClr = UIColor.systemGray6
        overDueProgress.progressClr = UIColor.red
        overDueProgress.setProgressWithAnimation(duration: 0.75, value: activityPercetage)
        completionRateProgress.trackClr = UIColor.systemGray6
        completionRateProgress.progressClr = UIColor.orange
        accuracyProgress.trackClr = UIColor.systemGray6
        accuracyProgress.progressClr = UIColor.systemGreen
        accuracyProgress.setProgressWithAnimation(duration: 0.75, value: 0.95)
        
        updateCompletionRateProgressBar()
        overDueProgressPercetange.text = "\(Int(activityPercetage * 100))"
        accuracyProgressPercentage.text = "\(Int(activityPercetage * 100))"
    }
    
    func updateCompletionRateProgressBar() {
        let completedTaskCount = tasks.filter { task in task.completed == true }.count
        let totoalTaskCount = tasks.count
        completionRateProgressPercentage.text = "\(Int(Float(completedTaskCount) / Float(totoalTaskCount) * 100))"
        completionRateProgress.setProgressWithAnimation(duration: 0.75, value: Float(completedTaskCount) / Float(totoalTaskCount))
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.configureCell(selected: true)
        activeGoals = tasks.filter { task in task.completed == false }
        updateCompletionRateProgressBar()
        self.goalTasks.reloadData()
        //TODO: Main taks list not getting updated properly due to indexpath is taken from the active goal list indexpath
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activeGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let task = activeGoals[indexPath.row]
        cell.taskLabel.text = task.task
        cell.configureCell(selected: task.completed)
        return cell
    }
}
