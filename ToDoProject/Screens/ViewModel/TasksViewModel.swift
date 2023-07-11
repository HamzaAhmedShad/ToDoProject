//
//  TasksViewModel.swift
//  ToDoProject
//
//  Created by BS1101 on 9/7/23.
//
import Firebase
import FirebaseFirestore

class TasksViewModel {
    
    private let db = Firestore.firestore()
    
    var tasks: [Task] = []
    
    func fetchTasks(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "TasksViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
            completion(.failure(error))
            return
        }
        
        let tasksCollectionRef = db.collection("users").document(userID).collection("tasks")
        
        tasksCollectionRef.getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success(()))
                return
            }
            
            self?.tasks = documents.compactMap { Task(document: $0) }
            if self?.tasks.isEmpty == true {
                // Tasks array is empty
                print("No tasks found")
            } else {
                // Tasks array has data
                print("Tasks found")
            }
            completion(.success(()))
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("TaskAddedNotification"), object: nil, queue: .main) { [weak self] _ in
            self?.fetchTasks { result in
                // Handle the result, and trigger completion if needed
            }
        }
    }
    func deleteTask(taskID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "TasksViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
            completion(.failure(error))
            return
        }
        
        let tasksCollectionRef = db.collection("users").document(userID).collection("tasks")
        let taskDocumentRef = tasksCollectionRef.document(taskID)
        
        taskDocumentRef.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("TaskAddedNotification"), object: nil)
    }
}
