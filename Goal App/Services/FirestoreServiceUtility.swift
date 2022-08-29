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

    public func save(id: String, task: String, createdDate: Date, dueDate: Date) {
        let docRef = database.collection("Goals").document(id)
        docRef.setData(["task": task, "completed": false, "goalCreatedDate": createdDate, "goalDueDate": dueDate])
    }
}
