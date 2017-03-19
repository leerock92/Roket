//
//  FriendsListViewController.swift
//  Roket
//
//  Created by Rock on 19/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FriendsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
        tableView.delegate = self
        tableView.dataSource = self
        }
    }
    @IBAction func dimissButtonTp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var displayImageView: UIImageView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
        fetchUsersFromFireB()
        

    }
    
    func fetchUsersFromFireB() {
        FIRDatabase.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            
             if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                print(user.username, user.email)
                //here might have some problem
                self.users.append(user)
                
                self.tableView.reloadData()
            }
            print(snapshot)
        })
    }
}

extension FriendsListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.email
        
        cell.imageView?.image = UIImage(named: "profileIcon")
        cell.imageView?.contentMode = .scaleAspectFit
        
        
        if let profileImageUrl = user.profileImageURL {
            let url = URL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                cell.imageView?.image = UIImage(data: data! )
            }).resume()
        }
        
        return cell
    }
    
    
}
