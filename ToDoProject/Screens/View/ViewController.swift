//
//  ViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 20/6/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var LetsStrtBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func letsStrtBtnPressed(_ sender: UIButton) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "LogInViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

