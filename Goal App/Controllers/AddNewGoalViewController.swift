//
//  NewGoalViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 28/07/22.
//

import UIKit
import FirebaseFirestore

class AddNewGoalViewController: UIViewController {
    
    let database = Firestore.firestore()
    
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
            saveNewGoal(task: goalName!, createdDate: goalCreatedDate.date, dueDate: goalDueDate.date)
            dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Goal Name is Needed", message: "Add proper goal name before saving goal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            self.present(alert, animated: true)
        }
    }
    
    func saveNewGoal(task: String, createdDate: Date, dueDate: Date) {
        let id = UUID()
        originalGoalsList.append( Goal(id: id, task: task, completed: false, goalCreatedDate: createdDate, goalDueDate: dueDate))
        let docRef = database.collection("Goals").document(id.uuidString)
        docRef.setData(["task": task, "completed": false, "goalCreatedDate": createdDate, "goalDueDate": dueDate])
    }
}

extension AddNewGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
