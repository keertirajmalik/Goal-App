//
//  FirestoreService.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 29/08/22.
//

import FirebaseFirestore
import Foundation

public class FirestoreServiceUtility {
    public static let shared = FirestoreServiceUtility()
    private let database = Firestore.firestore()

    private init() {}

    public func create(id: String, task: String, createdDate: Date, dueDate: Date) {
        let documentReference = database.collection("Goals").document(id)
        documentReference.setData(["task": task, "completed": false, "goalCreatedDate": createdDate, "goalDueDate": dueDate])
    }

    internal func getGoals(completionHandler: @escaping (Result<[Goal], Error>) -> Void) {
        database.collection("Goals").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    let result = snapshot.documents.map { document in
                        Goal(id: document.documentID, task: document["task"] as? String ?? "", completed: document["completed"] as? Bool ?? false, goalCreatedDate: document["goalCreatedDate"] as? Date ?? Date.now, goalDueDate: document["goalDueDate"] as? Date ?? Date.now)
                    }
                    completionHandler(.success(result))
                }
            } else {
                completionHandler(.failure(error!))
            }
        }
    }
}
