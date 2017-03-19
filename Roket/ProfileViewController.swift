//
//  ProfileViewController.swift
//  Roket
//
//  Created by Rock on 19/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    var ref = FIRDatabase.database().reference()
    
    let uid = FIRAuth.auth()?.currentUser?.uid
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var userProfilePicture: UIImageView!{
        didSet{
            userProfilePicture.layer.cornerRadius = userProfilePicture.frame.size.width / 2
            userProfilePicture.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userDisplayName: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImageUrl()
        displayUserName()
        
    }
    
    func fetchImageUrl() {
        ref.child("user").child(uid!).observe(.value, with: { (snapshot) in
            print(snapshot)
            
            let value = snapshot.value as? NSDictionary
            
            let imageUrl = value?["profileImageURL"] as? String ?? ""
            
            self.userProfilePicture.downloadImage(from: imageUrl)
            
        })
        
    }
    
    func displayUserName() {
        ref.child("user").child(uid!).observe(.value, with: {
            (snapshot) in
            
            print(snapshot)
            
            let value = snapshot.value as? NSDictionary
            let displayName = value?["username"] as? String ?? ""
            self.userNameTextField.text = displayName
            
        })
    }
}

extension UIImageView {
    func downloadImage(from ImgURL: String!){
        let url = URLRequest(url: URL(string: ImgURL)!)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        task.resume()
    }
}
