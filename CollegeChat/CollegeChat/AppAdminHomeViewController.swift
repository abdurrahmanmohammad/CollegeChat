//
//  AppAdminHomeViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 4/29/21.
//

import UIKit
import Parse

class AppAdminHomeViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        self.tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Since we are only displaying 3 columns
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppAdminHomeTableViewCell") as! AppAdminHomeTableViewCell
        var header = ""
        
        
        if indexPath.row == 0 {
            // Users
            header = "Users"
            let query = PFUser.query()
            do {
                let users = try query?.findObjects()
                cell.infoLabel.text = String(users!.count)
            } catch  {
              print(error)
            }
        } else if indexPath.row == 1 {
            // Colleges
            header = "Colleges"
            let query = PFQuery(className:"College")
            query.countObjectsInBackground { (count: Int32, error: Error?) in
                if let error = error {
                    // The request failed
                    print(error.localizedDescription)
                } else {
                    cell.infoLabel.text = String(count)
                    // print("\(count) objects found!")
                }
            }
            
        } else if indexPath.row == 2 {
            // Chatrooms
            header = "Chatrooms"
            let query = PFQuery(className:"Chatroom")
            query.countObjectsInBackground { (count: Int32, error: Error?) in
                if let error = error {
                    // The request failed
                    print(error.localizedDescription)
                } else {
                    cell.infoLabel.text = String(count)
                    // print("\(count) objects found!")
                }
            }
        }
        
        
        cell.headerLabel.text = header
        
        
        return cell
    }
}
