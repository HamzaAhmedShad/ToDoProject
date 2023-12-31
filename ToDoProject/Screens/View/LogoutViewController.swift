//
//  LogoutViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 4/7/23.
//

import UIKit

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var LogoutBtn: UIButton!
    
    @IBOutlet weak var BackBtnLog: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
    }
    @IBAction func LogoutBtnPressed(_ sender: UIButton) {
        guard let navigationController = self.navigationController else {
            return
        }
        // Pop all view controllers except the root view controller
        navigationController.popToRootViewController(animated: true)
    }
    
    @IBAction func BackBtnLogPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
