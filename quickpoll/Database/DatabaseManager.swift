//
//  DatabaseManager.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 26.08.22.
//

import Foundation
import Firebase

class DatabaseManager {
    static let instance = DatabaseManager()
    private let db = Firestore.firestore();
    
    private init() { }
    
    private func getQuery(ref: Query, query: DatabaseQuery) -> Query {
        switch query.compareOperator {
            
        case .isEqualTo:
            return ref.whereField(query.field, isEqualTo: query.value)
        case .isNotEqualTo:
            return ref.whereField(query.field, isNotEqualTo: query.value)
        case .isLessThan:
            return ref.whereField(query.field, isLessThan: query.value)
        case .isLessThanOrEqual:
            return ref.whereField(query.field, isLessThanOrEqualTo: query.value)
        case .isGreaterThan:
            return ref.whereField(query.field, isGreaterThan: query.value)
        case .isGreaterThanOrEqual:
            return ref.whereField(query.field, isGreaterThanOrEqualTo: query.value)
        case .isIn:
            return ref.whereField(query.field, in: query.values)
        case .isNotIn:
            return ref.whereField(query.field, notIn: query.values)
        case .arrayContains:
            return ref.whereField(query.field, arrayContains: query.value)
        case .arrayContainsAny:
            return ref.whereField(query.field, arrayContainsAny: query.values)
        }
    }
    
    func getData<T: Codable>(collection: String, as: T.Type, search: [DatabaseQuery]) async -> [T]? {
        let collectionRef = db.collection(collection)
        
        let query = search.reduce(collectionRef) { partialResult, dbQuery in
            return getQuery(ref: partialResult, query: dbQuery)
        }
        
        do {
            let documents = try await query.getDocuments().documents
            
            let data = try documents.map { document in
                return try document.data(as: T.self)
            }
            
            return data.isEmpty ? nil : data
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getData<T: Codable>(collection: String, as: T.Type) async -> [T]? {
        let collectionRef = db.collection(collection)
        
        do {
            let documents = try await collectionRef.getDocuments().documents
            
            let data = try documents.map { document in
                return try document.data(as: T.self)
            }
            
            return data.isEmpty ? nil : data
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getDocument<T: Codable>(collection: String, documentId: String, as: T.Type) async -> T? {
        let collectionRef = db.collection(collection)
        let documentRef = collectionRef.document(documentId)
        
        do {
            let document = try await documentRef.getDocument()
            
            let data = try document.data(as: T.self)
            return data
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func createDocument<T: Codable>(collection: String, data: T) async -> T? {
        let collectionRef = db.collection(collection)
        
        do {
            let documentRef = try collectionRef.addDocument(from: data)
            let document = try await documentRef.getDocument(as: T.self)
            
            return document
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func updateDocument(collection: String, documentId: String, data: [String : Any]) async {
        let collectionRef = db.collection(collection)
        let documentRef = collectionRef.document(documentId)
        
        do {
            try await documentRef.setData(data, merge: true)
        } catch {
            print(error)
        }
    }
    
    func listenDocument<T: Codable>(collection: String, documentId: String, as: T.Type, completion: @escaping (T) -> Void) -> ListenerRegistration {
        let collectionRef = db.collection(collection)
        let documentRef = collectionRef.document(documentId)
        
        return documentRef.addSnapshotListener { document, error in
            guard error == nil else { return }
            guard let document = document else { return }
            
            do {
                
                let data = try document.data(as: T.self)
                
                completion(data)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
