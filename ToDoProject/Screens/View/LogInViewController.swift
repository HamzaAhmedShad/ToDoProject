//
//  LogInViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 20/6/23.
//

import UIKit
import FirebaseAuth
class LogInViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var LogInBtn: UIButton!
    
    
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        guard let email = UserEmail.text, !email.isEmpty,
              let password = UserPassword.text, !password.isEmpty else {
            return
        }
        
        login(with: email, password: password)
    }
    
    func login(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
            
            print("User logged in successfully!")
            self.navigateToHomeScreen()
        }
    }
    
    func navigateToHomeScreen(){
        let vc1 = storyboard!.instantiateViewController(withIdentifier: "TasksViewController")
        self.navigationController?.pushViewController(vc1, animated: true)
    }
}
