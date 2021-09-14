//
//  CollegeSettingsViewController.swift
//  CollegeChat
//
//  Created by Anshul Jha on 4/30/21.
//

import UIKit
import Parse
import MBProgressHUD

class CollegeSettingsViewController: UIViewController {

    @IBOutlet weak var collegeNameTextField: UITextField!
    @IBOutlet weak var collegeEmailTextField: UITextField!
    @IBOutlet weak var collegeAddressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSave(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let college = PFObject(className: "College")
        
        let collegeName = collegeNameTextField.text ?? nil
        let collegeEmail = collegeEmailTextField.text ?? nil
        let collegeAddress = collegeAddressTextField.text ?? nil
        
        if collegeName != nil
        {
            college["name"] = collegeName
        }
        if collegeEmail != nil
        {
            college["address"] = collegeEmail
        }
        if collegeAddress != nil
        {
            college["email"] = collegeAddress
        }
        
        college.saveInBackground { success, error in
            if success {
                self.navigationController?.popViewController(animated: true)
                print("saved!")
                MBProgressHUD.hide(for: self.view, animated: true)
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onResetClasses(_ sender: Any) {
        let query = PFQuery(className: "Chatroom")
        
        var collegeName = PFUser.current()?["collegeName"]
        
        //let collegeName = user["collegeName"]
        
        query.whereKey("collegeName", equalTo: collegeName)
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                
                // Do something with the found objects
                for object in objects {
                    object["instructorEmail"] = "None"
                    let inviteCode = self.generateInviteCode()
                    object["inviteCode"] = inviteCode
                    object.saveInBackground()
                }
        
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    func generateInviteCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<8).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func onDeleteClasses(_ sender: Any) {
        let query = PFQuery(className: "Chatroom")
        
        let collegeName = PFUser.current()?["collegeName"]
        
        //let collegeName = user["collegeName"]
        
        query.whereKey("collegeName", equalTo: collegeName)
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    object.deleteInBackground()
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
