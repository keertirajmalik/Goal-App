//
//  ViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 09/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var username: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var overDueProgress: CircularProgressView!
    @IBOutlet var overDueProgressPercetange: UILabel!
    @IBOutlet var completionRateProgress: CircularProgressView!
    @IBOutlet var completionRateProgressPercentage: UILabel!
    @IBOutlet var accuracyProgress: CircularProgressView!
    @IBOutlet var accuracyProgressPercentage: UILabel!

    @IBOutlet var goalTasks: UITableView!

    var activeGoals: [Goal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        goalTasks.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goalTasks.dataSource = self
        goalTasks.delegate = self
        goalTasks.showsVerticalScrollIndicator = false
        setupProfileView()
    }

    override func viewWillAppear(_: Bool) {
        activeGoals = originalGoalsList.filter { task in task.completed == false }
        goalTasks.reloadData()
        progressCircleSetup()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateActiveGoalCompletedStatus(id: activeGoals[indexPath.row].id)
        progressCircleSetup()
        goalTasks.reloadData()
    }

    func updateActiveGoalCompletedStatus(id: UUID) {
        originalGoalsList[originalGoalsList.firstIndex(where: { $0.id == id })!].updateGoalCompletedStatus()
        activeGoals = originalGoalsList.filter { task in task.completed == false }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        activeGoals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let task = activeGoals[indexPath.row]
        cell.taskLabel.text = task.task
        cell.configureCell(selected: task.completed)
        return cell
    }
}

extension HomeViewController {
    func setupProfileView() {
        profileImage?.layer.cornerRadius = (profileImage?.frame.size.width ?? 0.0) / 2
        profileImage?.clipsToBounds = true
        profileImage?.layer.borderWidth = 3.0
        profileImage?.layer.borderColor = UIColor.white.cgColor
    }

    private func progressCircleSetup() {
        let activityPercetage = Float(0.60)
        overDueProgress.trackClr = UIColor.systemGray6
        overDueProgress.progressClr = UIColor.red
        completionRateProgress.trackClr = UIColor.systemGray6
        completionRateProgress.progressClr = UIColor.orange
        accuracyProgress.trackClr = UIColor.systemGray6
        accuracyProgress.progressClr = UIColor.systemGreen
        updateCompletionRateProgressCircle()
        updateOverDueRateProgressCircle()
        accuracyProgressPercentage.text = "\(Int(activityPercetage * 100))"
    }

    func updateCompletionRateProgressCircle() {
        completionRateProgressPercentage.text = "\(Int(completionRateCalculator() * 100))"
        completionRateProgress.setProgressWithAnimation(duration: 0.75, value: completionRateCalculator())
    }

    func completionRateCalculator() -> Float {
        let completedTaskCount = originalGoalsList.filter { task in task.completed == true }.count
        let totoalTaskCount = originalGoalsList.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(completedTaskCount) / Float(totoalTaskCount)
    }

    func updateOverDueRateProgressCircle() {
        overDueProgressPercetange.text = "\(Int(overDueRateCalculator() * 100))"
        overDueProgress.setProgressWithAnimation(duration: 0.75, value: overDueRateCalculator())
    }

    func overDueRateCalculator() -> Float {
        let overdueTaskCount = originalGoalsList.filter { task in
            task.goalDueDate < Date() && task.completed == false
        }.count
        let totoalTaskCount = originalGoalsList.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(overdueTaskCount) / Float(totoalTaskCount)
    }
}
