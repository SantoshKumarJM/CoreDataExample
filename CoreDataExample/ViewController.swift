//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Santosh on 27/10/20.
//  Copyright © 2020 Santosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    var userDetails: [UserInfoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchUserDetails()
    }
    
    @IBAction func addNewTapped(_ sender: Any) {
        let alertView = UIAlertController(title: "Add New Details", message: "Please Enter user Name and Phone number", preferredStyle: .alert)
        
        alertView.addTextField { (userName) in
            userName.text = ""
            userName.placeholder = " user name"
        }
        
        alertView.addTextField { (mobile) in
            mobile.text = ""
            mobile.placeholder = "+91 XXX-XXXX-XXXX"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (key) in
            let model = userInformationModel(mobile: (alertView.textFields?[1].text)!, userName: (alertView.textFields?[0].text)!)
            CoreDataManager.shared.saveUserInfo(model)
            self.fetchUserDetails()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
    
    //    MARK:- To fetch details from coreData
    func fetchUserDetails() {
        userDetails = CoreDataManager.shared.fetchEntity(UserInfoEntity.self) as! [UserInfoEntity]
        
        let showEmptyView = userDetails.count != 0 ? true : false
        emptyStateView.isHidden = showEmptyView
        detailsTableView.isHidden = !showEmptyView
        
        detailsTableView.reloadData()
    }
}

//MARK:- tableview delegates and datasources
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UICell", for: indexPath)
        cell.textLabel?.text = userDetails[indexPath.row].userName
        cell.detailTextLabel?.text = userDetails[indexPath.row].phoneNumer
        return cell
    }
    
    
}
