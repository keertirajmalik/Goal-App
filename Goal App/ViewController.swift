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
        completionRateProgress.setProgressWithAnimation(duration: 0.75, value: 0.95)
        accuracyProgress.trackClr = UIColor.systemGray6
        accuracyProgress.progressClr = UIColor.systemGreen
        accuracyProgress.setProgressWithAnimation(duration: 0.75, value: 0.95)
        
        overDueProgressPercetange.text = "\(Int(activityPercetage * 100))"
        completionRateProgressPercentage.text = "\(Int(activityPercetage * 100))"
        accuracyProgressPercentage.text = "\(Int(activityPercetage * 100))"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        tasks[indexPath.row].completed.toggle()
        cell.configureCell(selected: tasks[indexPath.row].completed)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.taskLabel.text = tasks[indexPath.row].task
        cell.configureCell(selected: tasks[indexPath.row].completed)
        return cell
    }
}
