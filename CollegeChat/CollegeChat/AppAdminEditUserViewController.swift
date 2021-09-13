//
//  AppAdminEditUserViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 4/30/21.
//

import UIKit
import Parse

class AppAdminEditUserViewController: UIViewController {
    var user: PFUser = PFUser()
    
    @IBOutlet weak var firstnameLabel: UITextField!
    @IBOutlet weak var lastnameLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameLabel.text = user["firstname"] as? String
        lastnameLabel.text = user["lastname"] as? String
        usernameLabel.text = user["username"] as? String
    }
    
    
    /*
    // Do not have the ability to delete other users
    @IBAction func deleteUser(_ sender: Any) {
        user.deleteInBackground()
    }
    
    // Do not have the ability to modify other users
    @IBAction func saveUser(_ sender: Any) {
        user["firstname"] = firstnameLabel.text
        user["lastname"] = lastnameLabel.text
        user["username"] = usernameLabel.text
        user["password"] = passwordLabel.text
        user.saveInBackground()
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
