//
//  AppAdminViewCollegesTableViewController.swift
//  CollegeChat
//
//  Created by Abdurrahman on 5/3/21.
//

import UIKit
import Parse

class AppAdminViewCollegesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var colleges = [PFObject]()
    var selectedCollege: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 80
        
        let query = PFQuery(className:"College")
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
            if results != nil {
                self.colleges = results!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppAdminCollegeTableViewCell", for: indexPath) as! AppAdminCollegeTableViewCell
        let college = colleges[indexPath.row]
        cell.collegeLabel.text = college["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedCollege = colleges[indexPath.row]
        performSegue(withIdentifier: "EditCollegeSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCollegeSegue" {
            let destination = segue.destination as! AppAdminEditCollegeViewController
            destination.college = selectedCollege
        }
    }
}
