//
//  NewGoalViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 28/07/22.
//

import UIKit

class NewGoalViewController: UIViewController {
    
    @IBOutlet weak var createdDateView: UIView!
    @IBOutlet weak var dueDateView: UIView!
    @IBOutlet weak var goalNameTextField: UITextField!
    @IBOutlet weak var goalCreatedDate: UIDatePicker!
    @IBOutlet weak var goalDueDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalNameTextField.becomeFirstResponder()
        goalNameTextField.delegate = self
        createdDateView.layer.cornerRadius = 5
        createdDateView.layer.masksToBounds = true
        dueDateView.layer.cornerRadius = 5
        dueDateView.layer.masksToBounds = true
        goalDueDate.date = Date.init(timeIntervalSinceNow: 60.0 * 60.0 * 24)
    }
    
    @IBAction func goalSaveButtonClicked(_ sender: UIButton) {
        let goalName = goalNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if goalName != nil && goalName != "" {
            goalNameTextField.resignFirstResponder()
            saveNewGoal(task: goalName!, createdDate: dateFor(dateString: goalCreatedDate.date, in: "IST"), dueDate: dateFor(dateString: goalDueDate.date, in: "IST"))
        } else {
            let alert = UIAlertController(title: "Goal Name is Needed", message: "Add proper goal name before saving goal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            self.present(alert, animated: true)
        }
    }
    
    func dateFor(dateString: Date, in timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .init(abbreviation: timezone)
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        return dateFormatter.string(from: dateString)
    }
    
    func saveNewGoal(task: String, createdDate: String, dueDate: String){
        originalGoalsList.append( Goal(id: UUID(), task: task, completed: false, goalCreatedDate: createdDate, goalDueDate: dueDate))
        dismiss(animated: true)
    }
}

extension NewGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
