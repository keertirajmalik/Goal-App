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
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

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
    }

    override func viewWillAppear(_: Bool) {
        getGoalsList()
        activeGoals = originalGoalsList?.filter { task in task.completed == false }
        goalTasks.reloadData()
        progressCircleSetup()
    }

    func getGoalsList() {
        showSpinner()
        firestoreUtil.getGoals { [weak self] response in
            switch response {
            case let .success(goalList):
                self?.originalGoalsList = goalList

            default:
                self?.originalGoalsList = []
            }
            DispatchQueue.main.async { [self] in
                self?.activeGoals = self?.originalGoalsList?.filter { task in task.completed == false }
                self?.goalTasks.reloadData()
                self?.progressCircleSetup()
                self?.stopSpinner()
            }
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
        cell.taskLabel.text = task?.task
        cell.configureCell(selected: task?.completed)
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
        let completedTaskCount = originalGoalsList?.filter { task in task.completed == true }.count
        let totoalTaskCount = originalGoalsList?.count
        if totoalTaskCount == 0 {
            return 0.0
        }
        return Float(completedTaskCount ?? 0) / Float(totoalTaskCount ?? 0)
    }

    func updateOverDueRateProgressCircle() {
        overDueProgressPercetange.text = "\(Int(overDueRateCalculator() * 100))"
        overDueProgress.setProgressWithAnimation(duration: 0.75, value: overDueRateCalculator())
    }

    func overDueRateCalculator() -> Float {
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
