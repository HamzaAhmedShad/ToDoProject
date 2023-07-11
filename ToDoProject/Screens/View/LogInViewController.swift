//
//  LogInViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 20/6/23.
//

import UIKit
import Firebase
import GoogleSignIn
class LogInViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var LogInBtn: UIButton!
    
    
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    @IBOutlet weak var ShowPasswordBtn: UIButton!
    
    @IBOutlet weak var GLogInBtn: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
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
    
    
    @IBAction func ShowPasswordBtnPressed(_ sender: UIButton) {
        UserPassword.isSecureTextEntry.toggle()
        
        // Update button image based on password visibility
        let imageName = UserPassword.isSecureTextEntry ? "eye.slash" : "eye"
        let image = UIImage(systemName: imageName)
        ShowPasswordBtn.setImage(image, for: .normal)
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

extension LogInViewController{
    
}
