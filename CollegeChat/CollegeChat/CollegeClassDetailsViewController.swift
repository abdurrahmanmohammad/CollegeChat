//
//  CollegeClassDetailsViewController.swift
//  CollegeChat
//
//  Created by Anshul Jha on 5/6/21.
//

import UIKit
import Parse

class CollegeClassDetailsViewController: UIViewController {

    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var instructorEmailTextField: UITextField!
    @IBOutlet weak var inviteCodeLabel: UILabel!
    var chatroom: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classNameTextField.placeholder = chatroom?["chatName"] as? String
        instructorEmailTextField.placeholder = chatroom?["instructorEmail"] as? String
        inviteCodeLabel.text = chatroom?["inviteCode"] as? String
    }
    
    @IBAction func onRefreshInviteCode(_ sender: Any) {
        inviteCodeLabel.text = generateInviteCode()
        chatroom!["inviteCode"] = inviteCodeLabel.text
        chatroom!.saveInBackground()
    }
    
    @IBAction func onSave(_ sender: Any) {
        chatroom?["chatName"] = classNameTextField.text
        chatroom?["instructorEmail"] = instructorEmailTextField.text
        chatroom?["inviteCode"] = inviteCodeLabel.text
        chatroom?.saveInBackground()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onDelete(_ sender: Any) {
        chatroom?.deleteInBackground()
        self.navigationController?.popViewController(animated: true)
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
