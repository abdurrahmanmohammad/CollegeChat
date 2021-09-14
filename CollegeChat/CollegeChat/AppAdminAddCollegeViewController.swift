//
//  AppAdminAddCollegeViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 5/3/21.
//

import UIKit
import Parse

class AppAdminAddCollegeViewController: UIViewController {
    @IBOutlet weak var collegeName: UITextField!
    @IBOutlet weak var collegeEmail: UITextField!
    @IBOutlet weak var collegeAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCollege(_ sender: Any) {
        let parseObject = PFObject(className:"College")
        parseObject["name"] = collegeName.text
        parseObject["address"] = collegeEmail.text
        parseObject["email"] = collegeAddress.text

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
            self.performSegue(withIdentifier: "SaveCollegeSegue", sender: self)
          } else {
            // There was a problem, check error.description
            print(error.debugDescription)
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
