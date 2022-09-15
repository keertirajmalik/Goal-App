//
//  FirestoreService.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 29/08/22.
//

import FirebaseFirestore
import Foundation

public class FirestoreService {
    public static let shared = FirestoreService()
    private let database = Firestore.firestore()

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

    func updateGoalsCompleteStatus(id: String?, completed: Bool?) {
        guard let id = id, let completed = completed else { return }
        database.collection("Goals").document(id).setData(["completed": completed], merge: true) { error in
            if let error = error {
                debugPrint(error)
            }
        }
    }

    func createUser(user: User) {
        guard let userName = user.userName, let userEmail = user.email, let uid = user.userId else { return }
        database.collection("Users").addDocument(data: ["userName": userName, "userEmail": userEmail, "uid": uid]) { error in
            if let error = error {
                debugPrint(error)
            }
        }
    }
}
