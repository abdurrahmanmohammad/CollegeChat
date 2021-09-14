//
//  AppAdminEditCollegeViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 5/3/21.
//

import UIKit
import Parse

class AppAdminEditCollegeViewController: UIViewController {
    var college: PFObject = PFObject(className: "College")
    @IBOutlet weak var collegeNameLabel: UITextField!
    @IBOutlet weak var collegeEmailLabel: UITextField!
    @IBOutlet weak var collegeAddressLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        collegeNameLabel.text = college["name"] as? String
        collegeEmailLabel.text = college["email"] as? String
        collegeAddressLabel.text = college["address"] as? String
    }
    
    @IBAction func deleteCollege(_ sender: Any) {
        college.deleteInBackground()
        performSegue(withIdentifier: "ReturnSegue", sender: self)
    }
    
    @IBAction func saveCollege(_ sender: Any) {
        college["name"] = collegeNameLabel.text
        college["email"] = collegeEmailLabel.text
        college["address"] = collegeAddressLabel.text
        college.saveInBackground()
        performSegue(withIdentifier: "ReturnSegue", sender: self)
    }
    
    @IBAction func admin(_ sender: Any) {
        performSegue(withIdentifier: "AdminSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdminSegue" {
            let destination = segue.destination as! AppAdminViewCollegeAdminViewController
            destination.college = college
        }

    }
    
}
