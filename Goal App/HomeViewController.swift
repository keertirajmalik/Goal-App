//
//  ViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 09/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var overDueProgress: CircularProgressView!
    @IBOutlet weak var overDueProgressPercetange: UILabel!
    @IBOutlet weak var completionRateProgress: CircularProgressView!
    @IBOutlet weak var completionRateProgressPercentage: UILabel!
    @IBOutlet weak var accuracyProgress: CircularProgressView!
    @IBOutlet weak var accuracyProgressPercentage: UILabel!
    
    @IBOutlet weak var goalTasks: UITableView!
    
    var activeGoals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        goalTasks.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goalTasks.dataSource = self
        goalTasks.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activeGoals = originalGoalsList.filter { task in task.completed == false }
        goalTasks.reloadData()
        progressCircleSetup()
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
        updateOverDueRateProgressBar()
        accuracyProgressPercentage.text = "\(Int(activityPercetage * 100))"
    }
    
    func updateCompletionRateProgressBar() {
        completionRateProgressPercentage.text = "\(Int(completionRateCalculator() * 100))"
        completionRateProgress.setProgressWithAnimation(duration: 0.75, value: completionRateCalculator())
    }
    
    func completionRateCalculator() -> Float{
        let completedTaskCount = originalGoalsList.filter { task in task.completed == true }.count
        let totoalTaskCount = originalGoalsList.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(completedTaskCount) / Float(totoalTaskCount)
    }
    
    func updateOverDueRateProgressBar() {
        overDueProgressPercetange.text = "\(Int(overDueRateCalculator() * 100))"
        overDueProgress.setProgressWithAnimation(duration: 0.75, value: overDueRateCalculator())
    }
    
    func overDueRateCalculator() -> Float{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        
        let overdueTaskCount = originalGoalsList.filter { task in
            dateFormatter.date(from: task.goalDueDate) ?? Date() < Date() && task.completed == false
        }.count
        let totoalTaskCount = originalGoalsList.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        
        return Float(overdueTaskCount) / Float(totoalTaskCount)
    }
    
    func updateActiveGoalCompletedStatus(id: UUID){
        originalGoalsList[originalGoalsList.firstIndex(where: {$0.id == id})!].updateGoalCompletedStatus()
        activeGoals = originalGoalsList.filter { task in task.completed == false }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateActiveGoalCompletedStatus(id: activeGoals[indexPath.row].id)
        progressCircleSetup()
        goalTasks.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
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
