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

    func create(id: String, task: String, createdDate: Date, dueDate: Date) {
        let documentReference = database.collection("Goals").document(id)
        documentReference.setData(["task": task, "completed": false, "goalCreatedDate": createdDate, "goalDueDate": dueDate])
    }

    func getGoals() async -> [Goal]? {
        do {
            let snapshot = try await database.collection("Goals").getDocuments()
            return snapshot.documents.map { document in
                Goal(id: document.documentID, task: document["task"] as? String ?? "", completed: document["completed"] as? Bool ?? false, goalCreatedDate: document["goalCreatedDate"] as? Date ?? Date.now, goalDueDate: document["goalDueDate"] as? Date ?? Date.now)
            }
        } catch {
            return nil
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
