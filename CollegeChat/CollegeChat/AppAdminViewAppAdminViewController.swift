//
//  AppAdminViewAppAdminViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 4/30/21.
//

import UIKit
import Parse

class AppAdminViewAppAdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var users = [PFObject]()
    var selectedUser: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 80
        
        let query = PFUser.query()
        query?.whereKey("accountType", equalTo:"App Admin")
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
        self.selectedUser = users[indexPath.row] as! PFUser // Get selected User object
        performSegue(withIdentifier: "EditUserSegue", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditUserSegue" {
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! AppAdminEditUserViewController
            // Pass the selected object to the new view controller.
            destination.user = selectedUser
        }
    }

}
