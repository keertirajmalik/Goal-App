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
    }
    
    @IBAction func goalSaveButtonClicked(_ sender: UIButton) {
        goalNameTextField.resignFirstResponder()
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
