//
//  AppAdminViewCollegeAdminViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 5/3/21.
//

import UIKit
import Parse

class AppAdminViewCollegeAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var college = PFObject(className: "College")
    @IBOutlet weak var tableView: UITableView!
    var users = [PFObject]()
    var selectedUser: PFUser!
    
    @IBAction func plusButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateCollegeAdminSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 80
        
        let query = PFUser.query()
        query?.whereKey("accountType", equalTo:"College Admin")
        query?.whereKey("collegeName", equalTo: college["name"] as! String)
        query?.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
            if results != nil {
                self.users = results!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppAdminUsersTableViewCell", for: indexPath) as! AppAdminUsersTableViewCell

        let user = users[indexPath.row] as! PFUser
        cell.usernameLabel.text = user["username"] as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedUser = users[indexPath.row] as? PFUser // Get selected User object
        performSegue(withIdentifier: "EditUserSegue", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateCollegeAdminSegue" {
            let destination = segue.destination as! AppAdminCreateCollegeAdminViewController
            destination.college = college // Pass selected college
        } else if segue.identifier == "EditUserSegue" {
            let destination = segue.destination as! AppAdminEditUserViewController
            destination.user = selectedUser
        }
    }
}
