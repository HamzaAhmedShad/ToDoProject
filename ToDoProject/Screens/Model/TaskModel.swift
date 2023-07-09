//
//  TaskModel.swift
//  ToDoProject
//
//  Created by BS1101 on 9/7/23.
//

import Foundation
import FirebaseFirestore
struct Task {
    let id: String
    let title: String
    let description: String

    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let id = data["id"] as? String,
              let title = data["title"] as? String,
              let description = data["description"] as? String else {
            return nil
        }
        
        self.id = id
        self.title = title
        self.description = description
    }
}
