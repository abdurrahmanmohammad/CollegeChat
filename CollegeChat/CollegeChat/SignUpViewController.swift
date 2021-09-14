//SIGNUPVC
//
//  SignUpViewController.swift
//  CollegeChat
//
//  Created by Anshul Jha on 4/20/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
 
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        dateOfBirthTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SignUpViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        datePicker?.preferredDatePickerStyle = .wheels
        dateOfBirthTextField.inputView = datePicker
        
    }
    
    @IBAction func viewDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
    }

    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.username = usernameTextField.text
        user["accountType"] = "Student"
        user["firstname"] = firstNameTextField.text
        user["lastname"] = lastNameTextField.text
        user["DOB"] = dateOfBirthTextField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    
    @IBAction func loginBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
