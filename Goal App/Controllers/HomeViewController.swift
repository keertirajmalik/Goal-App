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

    var originalGoalsList: [Goal]? = []
    var activeGoals: [Goal]?
    let firestoreUtil = FirestoreService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        goalTasks.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        goalTasks.dataSource = self
        goalTasks.delegate = self
        goalTasks.showsVerticalScrollIndicator = false
        setupProfileView()
        navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewWillAppear(_: Bool) {
        getGoalsList()
        username.text = "Keertiraj Malik"
        activeGoals = originalGoalsList?.filter { task in task.completed == false }
        goalTasks.reloadData()
        progressCircleSetup()
    }

    private func getGoalsList() {
        showSpinner()
        Task {
            originalGoalsList = await firestoreUtil.getGoals()
            activeGoals = originalGoalsList?.filter { task in task.completed == false }
            goalTasks.reloadData()
            progressCircleSetup()
            stopSpinner()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "showPersonalGoals" {
            let controller = segue.destination as? PersonalGoalsViewController
            controller?.originalGoalsList = originalGoalsList
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = activeGoals?[indexPath.row].id
        updateActiveGoalCompletedStatus(id: id)
        firestoreUtil.updateGoalsCompleteStatus(id: id, completed: true)
        progressCircleSetup()
        goalTasks.reloadData()
    }

    func updateActiveGoalCompletedStatus(id: String?) {
        if let id = id {
            if let index = originalGoalsList?.firstIndex(where: { $0.id == id }) {
                originalGoalsList?[index].updateGoalCompletedStatus()
                activeGoals = originalGoalsList?.filter { task in task.completed == false }
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
        completionRateProgressPercentage.text = "\(Int(completionRateCalculator() * 100))"
        completionRateProgress.setProgressWithAnimation(duration: 0.75, value: completionRateCalculator())
    }

    private func completionRateCalculator() -> Float {
        let completedTaskCount = originalGoalsList?.filter { task in task.completed == true }.count
        let totoalTaskCount = originalGoalsList?.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(completedTaskCount ?? 0) / Float(totoalTaskCount ?? 0)
    }

    private func updateOverDueRateProgressCircle() {
        overDueProgressPercetange.text = "\(Int(overDueRateCalculator() * 100))"
        overDueProgress.setProgressWithAnimation(duration: 0.75, value: overDueRateCalculator())
    }

    private func overDueRateCalculator() -> Float {
        let overdueTaskCount = originalGoalsList?.filter { task in
            task.goalDueDate < Date() && task.completed == false
        }.count
        let totoalTaskCount = originalGoalsList?.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(overdueTaskCount ?? 0) / Float(totoalTaskCount ?? 0)
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
