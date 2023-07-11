//
//  RegisterViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 21/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var RegLoginBtn: UIButton!
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBOutlet weak var ShowPasswordBtn: UIButton!
    
    @IBOutlet weak var TCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
    }
    @IBAction func RegLoginPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
        guard let email = UserEmail.text, !email.isEmpty,
              let name = UserName.text, !name.isEmpty,
              let password = UserPassword.text, !password.isEmpty else {
            // Handle empty fields error
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){
            (authResult, error) in if let error = error{
                print("Registration error: \(error.localizedDescription)")
                return
            }
            guard let userID = authResult?.user.uid else {
                print("User ID not found")
                return
            }
            let db = Firestore.firestore()
            let userDocumentRef = db.collection("users").document(userID)
            
            userDocumentRef.setData([
                "name": name,
                "email": email,
                "id": userID
            ]) { error in
                if let error = error {
                    print("Error adding user document: \(error.localizedDescription)")
                } else {
                    print("User document added successfully!")
                }
            }
            print("User Registered Successfully!")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ShowPasswordBtnPressed(_ sender: UIButton) {
        UserPassword.isSecureTextEntry.toggle()
        
        // Update button image based on password visibility
        let imageName = UserPassword.isSecureTextEntry ? "eye.slash" : "eye"
        let image = UIImage(systemName: imageName)
        ShowPasswordBtn.setImage(image, for: .normal)
    }
    
    @IBAction func TCBtnPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let imageName = sender.isSelected ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)
        sender.setImage(image, for: .normal)
    }
    
}
