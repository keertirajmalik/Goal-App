//
//  ViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 09/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var username: UILabel!
    @IBOutlet private var profileImage: UIImageView!
    @IBOutlet private var overDueProgress: CircularProgressView!
    @IBOutlet private var overDueProgressPercetange: UILabel!
    @IBOutlet private var completionRateProgress: CircularProgressView!
    @IBOutlet private var completionRateProgressPercentage: UILabel!
    @IBOutlet private var accuracyProgress: CircularProgressView!
    @IBOutlet private var accuracyProgressPercentage: UILabel!
    @IBOutlet private var goalTasks: UITableView!
    @IBOutlet private var loadingView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    var activeGoals: [Goal]?
    var originalGoals: [Goal]?
    private var goalFetchService: GoalDataFetch = GoalsDataFetchService()

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTasks.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goalTasks.dataSource = self
        goalTasks.delegate = self
        goalTasks.showsVerticalScrollIndicator = false
        setupProfileView()
        navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewWillAppear(_: Bool) {
        username.text = "Keertiraj Malik"
        showSpinner()
        Task {
            originalGoals = await goalFetchService.fetchAllGoals()
            activeGoals = await goalFetchService.fetchActiveGoals()
            goalTasks.reloadData()
            progressCircleSetup()
            stopSpinner()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = activeGoals?[indexPath.row].id
        updateActiveGoalCompletedStatus(id: id)
    }

    func updateActiveGoalCompletedStatus(id: String?) {
        if let id = id {
            if let index = originalGoals?.firstIndex(where: { $0.id == id }) {
                originalGoals?[index].updateGoalCompletedStatus()
                activeGoals = originalGoals?.filter { task in task.completed == false }
                goalFetchService.updateGoalsCompleteStatus(id: id, completed: true)
                progressCircleSetup()
                goalTasks.reloadData()
            }
        } else {
            return
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        activeGoals?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let task = activeGoals?[indexPath.row]
        cell.configureCell(taskName: task?.task, selected: task?.completed)
        return cell
    }
}

extension HomeViewController {
    private func setupProfileView() {
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

    private func updateCompletionRateProgressCircle() {
        Task {
            originalGoals = await goalFetchService.fetchAllGoals()
            completionRateProgressPercentage.text = "\(Int(goalFetchService.completionRateCalculator(originalGoals: originalGoals) * 100))"
            completionRateProgress.setProgressWithAnimation(duration: 0.75, value: goalFetchService.completionRateCalculator(originalGoals: originalGoals))
        }
    }

    private func updateOverDueRateProgressCircle() {
        Task {
            originalGoals = await goalFetchService.fetchAllGoals()
            overDueProgressPercetange.text = "\(Int(goalFetchService.overDueRateCalculator(originalGoals: originalGoals) * 100))"
            overDueProgress.setProgressWithAnimation(duration: 0.75, value: goalFetchService.overDueRateCalculator(originalGoals: originalGoals))
        }
    }
}

extension HomeViewController {
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }

    private func stopSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
}
