//
//  RegisterViewController.swift
//  Roket
//
//  Created by Rock on 17/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    //------------------UI connections-------------------
    @IBOutlet weak var registerUserName: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var registerButtonTap: UIButton!{
        didSet{
            registerButtonTap.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var userSelectedImage: UIImageView!{
        didSet{
            userSelectedImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
            userSelectedImage.isUserInteractionEnabled = true
            userSelectedImage.layer.cornerRadius = userSelectedImage.frame.size.width / 2
            userSelectedImage.clipsToBounds = true
        }
    }
    
    @IBAction func dismissButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    var profilePictureUrl : URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //---------------function section-------------------
    func handleSignUp() {
        
        let username = registerUserName.text
        let email = registerEmail.text
        let password = registerPassword.text
        
        
        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user, error) in
            if error != nil{
                print(error! as NSError)
                //if user input error/mising info this pop up will appear. (userDidNotFillUp)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let imageName = NSUUID().uuidString
            
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.userSelectedImage.image!){
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        let values = ["username": username, "email": email, "profileImageURL": profileImageURL]
                        
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                    
                })
            }
            
        })
    }
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String : AnyObject]) {
        let ref = FIRDatabase.database().reference()
        ref.child("user").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print("err")
                return
            }
    })
}

    func uploadProfilePicture(image: UIImage){
        let storageRef = FIRStorage.storage().reference()
        let metadata = FIRStorageMetadata()
        
        // Giving stored data a type of data
        metadata.contentType = "image/jpeg"
        
        // Giving a name to profilePicture selected
        let timestamp = String(Date.timeIntervalSinceReferenceDate)
        let convertedTimeStamp = timestamp.replacingOccurrences(of: ".", with: "")
        let profilePictureName = ("image \(convertedTimeStamp).jpeg")
        
        
        // Making sure there is a profilePicture before proceeding, if nil then return
        guard let profilePictureData = UIImageJPEGRepresentation(image, 0.8) else {return}
        
        // Uploading image to firebase storage
        storageRef.child(profilePictureName).put(profilePictureData, metadata: metadata) { (meta, error) in
            
            // Returning to chat by dismissing current view controller
            self.dismiss(animated: true, completion: nil)
            
            if error != nil {
                print("No image detected")
                return
            }
            
            if let downloadUrl = meta?.downloadURL(){
                // Step 1 of setting image url string
                self.profilePictureUrl = downloadUrl
            }
        }
    }
    
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
            
        }
        if let selectedImage = selectedImageFromPicker {
            userSelectedImage.image = selectedImage
        }
        
        //uploadProfilePicture(image: selectedImageFromPicker!)
        
        dismiss(animated: true, completion: nil)
    }
}






