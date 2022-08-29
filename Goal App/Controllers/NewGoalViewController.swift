//
//  NewGoalViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 28/07/22.
//

import UIKit

class NewGoalViewController: UIViewController {
    @IBOutlet var createdDateView: UIView!
    @IBOutlet var dueDateView: UIView!
    @IBOutlet var goalNameTextField: UITextField!
    @IBOutlet var goalCreatedDate: UIDatePicker!
    @IBOutlet var goalDueDate: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        goalNameTextField.becomeFirstResponder()
        goalNameTextField.delegate = self
        createdDateView.layer.cornerRadius = 5
        createdDateView.layer.masksToBounds = true
        dueDateView.layer.cornerRadius = 5
        dueDateView.layer.masksToBounds = true
        goalDueDate.date = Date(timeIntervalSinceNow: 60.0 * 60.0 * 24)
    }

    @IBAction func goalSaveButtonClicked(_: UIButton) {
        let goalName = goalNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if goalName != nil, goalName != "" {
            goalNameTextField.resignFirstResponder()
            saveNewGoal(task: goalName!, createdDate: goalCreatedDate.date, dueDate: goalDueDate.date)
            dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Goal Name is Needed", message: "Add proper goal name before saving goal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            present(alert, animated: true)
        }
    }

    func saveNewGoal(task: String, createdDate: Date, dueDate: Date) {
        originalGoalsList.append(Goal(id: UUID(), task: task, completed: false, goalCreatedDate: createdDate, goalDueDate: dueDate))
    }
}

extension NewGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason _: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
