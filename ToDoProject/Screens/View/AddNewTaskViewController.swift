//
//  AddNewTaskViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 22/6/23.
//

import UIKit
import Firebase
import FirebaseFirestore
class AddNewTaskViewController: UIViewController {
    
    @IBOutlet weak var TaskTitleField: UITextField!
    
    @IBOutlet weak var TaskDetailsField: UITextField!
    
    @IBOutlet weak var AddTaskBtn: UIButton!
    
    @IBOutlet weak var BackBtnNew: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func BackBtnNewPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddTaskBtnPressed(_ sender: UIButton) {
        guard let taskTitle = TaskTitleField.text, !taskTitle.isEmpty,
              let taskDescription = TaskDetailsField.text, !taskDescription.isEmpty else {
            print("Task title or details empty")
            return
        }
        saveTaskToFirestore(taskTitle: taskTitle, taskDetails: taskDescription)
        navigationController?.popViewController(animated: true)
    }
    
    func saveTaskToFirestore(taskTitle: String, taskDetails: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        let db = Firestore.firestore()
        let tasksCollectionRef = db.collection("users").document(userID).collection("tasks")
        let newTaskDocumentRef = tasksCollectionRef.document()
        let taskID = newTaskDocumentRef.documentID
        
        newTaskDocumentRef.setData([
            "id": taskID,
            "title": taskTitle,
            "details": taskDetails
        ]) { error in
            if let error = error {
                print("Error adding task: \(error.localizedDescription)")
            } else {
                print("Task added successfully!")
                NotificationCenter.default.post(name: NSNotification.Name("TaskAddedNotification"), object: nil)
            }
        }
    }
}
