//
//  LoginViewController.swift
//  Roket
//
//  Created by Rock on 17/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    //UI for loginPage

    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButtonPressed: UIButton!{
        didSet{
            loginButtonPressed.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var registerButtonPressed: UIButton!{
        didSet{
            registerButtonPressed.addTarget(self, action: #selector(presentRegisterPage), for: .touchUpInside)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //-----------------function sections------------------
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: loginEmailTextField.text!, password: loginPasswordTextField.text!, completion: { (user, error) in
            if error != nil {
                print(error! as NSError)
                print("failed to log in")
                return
            }else{
                print("successfully log in")
                self.presentMainViewController()
            }
        })
    }
    
    func presentRegisterPage() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        
        present(controller!, animated: true, completion: nil)
    }
    
    func presentMainViewController() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        
        present(controller!, animated: true, completion: nil)
    }

}
