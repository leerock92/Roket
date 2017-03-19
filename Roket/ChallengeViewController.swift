//
//  ChallengeViewController.swift
//  Roket
//
//  Created by Rock on 19/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.addTarget(self, action: #selector(presentMainController), for: .touchUpInside)
        }
    }
    @IBOutlet weak var challengeButtonTap: UIButton!{
        didSet{
            challengeButtonTap.addTarget(self, action: #selector(presentFriendList), for: .touchUpInside)
            challengeButtonTap.layer.cornerRadius = challengeButtonTap.frame.size.width / 2
            challengeButtonTap.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func presentFriendList() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FriendsListViewController")
        
        present(controller!, animated: true, completion: nil)
    }
    
    func presentMainController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

