//
//  AppAdminCreateAppAdminViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 4/30/21.
//

import UIKit
import Parse

class AppAdminCreateAppAdminViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = usernameField.text
        user["accountType"] = "App Admin"
        user["firstname"] = firstnameField.text
        user["lastname"] = lastnameField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "RegisterCompletionSegue", sender: self)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
