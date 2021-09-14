//
//  AddClassViewController.swift
//  CollegeChat
//
//  Created by Anshul Jha on 4/30/21.
//

import UIKit
import Parse
import MBProgressHUD

class AddClassCollegeViewController: UIViewController {

    @IBOutlet weak var classNameTextField: UITextField!

    @IBOutlet weak var instructorEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Cancel"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddClass(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let chatroom = PFObject(className: "Chatroom")
        
        let query = PFUser.query()
        query!.whereKey("objectId", equalTo: PFUser.current()!.objectId!)
       /* var user = PFUser.current()
        do {
            user = try query!.findObjects().first as! PFUser
            
        } catch let error {
            print("error retrieving error: \(error)")
        }*/
        let chatName = classNameTextField.text
        let instructorEmail = instructorEmailTextField.text
        let collegeName = PFUser.current()?["collegeName"]
        
        chatroom["chatName"] = chatName
        chatroom["instructorEmail"] = instructorEmail
        chatroom["collegeName"] = collegeName
        chatroom["collegeName"] = "testCollege"
        chatroom["inviteCode"] = generateInviteCode()
        
        chatroom.saveInBackground { success, error in
            if success {
                self.navigationController?.popViewController(animated: true)
                print("saved!")
                MBProgressHUD.hide(for: self.view, animated: true)
            } else {
                print("error!")
            }
        }
    }
    
    func generateInviteCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<8).map{ _ in letters.randomElement()! })
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
