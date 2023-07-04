//
//  RegisterViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 21/6/23.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var RegLoginBtn: UIButton!
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    @IBOutlet weak var SignUpBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationItem.setHidesBackButton(true, animated:true)
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
            print("User Registered Successfully!")
        }
        navigationController?.popViewController(animated: true)
    }
}
