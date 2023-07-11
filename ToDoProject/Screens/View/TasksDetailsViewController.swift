//
//  TasksDetailsViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 4/7/23.
//

import UIKit

class TasksDetailsViewController: UIViewController {
    
    @IBOutlet weak var TaskTitleDetails: UILabel!
    
    @IBOutlet weak var TaskDescriptionDetails: UILabel!
    
    @IBOutlet weak var BackBtnDetails: UIButton!
    
    @IBOutlet weak var DeleteBtnDetails: UIButton!
    
    var viewModel = TasksViewModel()
    var tasks: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        configTask()
        
        // Do any additional setup after loading the view.
    }
    func configTask(){
        if let tasks = tasks{
            TaskTitleDetails.text = tasks.title
            TaskDescriptionDetails.text = tasks.description
        }
    }
    
    @IBAction func BackBtnDetailsPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DeleteBtnDetailsPressed(_ sender: UIButton) {
        guard let taskID = tasks?.id else {
            return
        }
        
        // Delete the task from Firestore
        viewModel.deleteTask(taskID: taskID) { [weak self] result in
            switch result {
            case .success:
                // Task deleted successfully, pop the view controller
                self?.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("TaskDeletedNotification"), object: nil)
            case .failure(let error):
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}
