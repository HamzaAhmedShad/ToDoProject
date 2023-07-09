//
//  TasksViewModel.swift
//  ToDoProject
//
//  Created by BS1101 on 9/7/23.
//

import Foundation
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
        
        tasksCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success(()))
                return
            }
            
            self.tasks = documents.compactMap { Task(document: $0) }
            
            completion(.success(()))
        }
    }
}
