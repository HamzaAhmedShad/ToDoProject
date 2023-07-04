//
//  TasksViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 21/6/23.
//

import UIKit

class TasksViewController: UIViewController {
    
    
    @IBOutlet weak var GotoProfileBtn: UIButton!
    
    
    @IBOutlet weak var TasksTableView: UITableView!
    
    @IBOutlet weak var AddNewTaskBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //                navigationController?.setNavigationBarHidden(true, animated: true)
        TasksTableView.register(UINib(nibName: "TasksTableViewCell", bundle: .main), forCellReuseIdentifier: "TasksTableViewCell")
        TasksTableView.rowHeight = 80
    }
    @IBAction func AddNewTaskBtnPressed(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "AddNewTaskViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToProfilePressed(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "LogoutViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
}
extension TasksViewController: UITableViewDelegate, UITableViewDataSource{
    //    TasksTableView.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell{
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TasksTableView.deselectRow(at: indexPath, animated: false)
        
    }
}
