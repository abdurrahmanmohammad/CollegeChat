//
//  AppAdminCreateCollegeAdminViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 5/3/21.
//

import UIKit
import Parse

class AppAdminCreateCollegeAdminViewController: UIViewController {
    var college: PFObject = PFObject(className: "College")
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
        user["firstname"] = firstnameField.text
        user["lastname"] = lastnameField.text
        user["accountType"] = "College Admin"
        user["collegeName"] = college["name"]
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "RegisterCompletionSegue", sender: self)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterCompletionSegue" {
            let destination = segue.destination as! AppAdminViewCollegeAdminViewController
            destination.college = college
        }
    }

}
