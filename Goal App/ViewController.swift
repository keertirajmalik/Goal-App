//
//  ViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 09/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = ["Write an article or blogpost","Dribble Concept","Behance case study","Conduct exam"]
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var circularProgress1: CircularProgressView!
    @IBOutlet weak var circle1Percentage: UILabel!
    @IBOutlet weak var circularProgress2: CircularProgressView!
    @IBOutlet weak var circle2Percentage: UILabel!
    @IBOutlet weak var circularProgress3: CircularProgressView!
    @IBOutlet weak var circle3Percentage: UILabel!
    
    @IBOutlet weak var goalTasks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let activityPercetage = Float(0.60)
        circularProgress1.trackClr = UIColor.systemGray6
        circularProgress1.progressClr = UIColor.red
        circularProgress1.setProgressWithAnimation(duration: 0.75, value: activityPercetage)
        circularProgress2.trackClr = UIColor.systemGray6
        circularProgress2.progressClr = UIColor.orange
        circularProgress2.setProgressWithAnimation(duration: 0.75, value: 0.95)
        circularProgress3.trackClr = UIColor.systemGray6
        circularProgress3.progressClr = UIColor.systemGreen
        circularProgress3.setProgressWithAnimation(duration: 0.75, value: 0.95)
        
        circle1Percentage.text = "\(Int(activityPercetage * 100))"
        circle2Percentage.text = "\(Int(activityPercetage * 100))"
        circle3Percentage.text = "\(Int(activityPercetage * 100))"

        goalTasks.dataSource = self
        goalTasks.delegate = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        goalTasks.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //TODO: Disable the box highlight when user select a row and call taskCompleted method from TableViewCell
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.taskLabel.text = tasks[indexPath.row]
        return cell
    }

    
}
