//
//  GroupViewModel.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 26.08.22.
//

import Foundation
import CoreImage
import UIKit

class GroupViewModel: ObservableObject {
    @Published var groups: [PollGroup]?
    @Published var errorMessage: String?
    
    private let db = DatabaseManager.instance
    private let auth = AuthManager.instance
    
    func getGroups() async {
        let groups = await db.getData(collection: "groups", as: PollGroup.self, search: [
            DatabaseQuery(field: "users", compareOperator: .arrayContains, value: auth.getUser()?.uid ?? "")
        ])
        
        DispatchQueue.main.async {
            self.groups = groups
        }
    }
    
    func createGroup(name: String) async {
        
        if name.isEmpty { return }
        
        let group = await db.createDocument(collection: "groups", data: PollGroup(
            name: name,
            code: UUID().uuidString,
            users: [
                auth.getUser()?.uid ?? ""
            ]
        ))
        
        if group == nil {
            DispatchQueue.main.async {
                self.errorMessage = "Gruppe konnte nicht erstellt werden."
            }
        }
    }
    
    func joinGroup(code: String) async {
        
        let userId = auth.getUser()?.uid ?? ""
        
        let group = await db.getData(collection: "groups", as: PollGroup.self, search: [
            DatabaseQuery(field: "code", compareOperator: .isEqualTo, value: code)
        ])?.first
        
        guard let group = group else {
            DispatchQueue.main.async {
                self.errorMessage = "Gruppe wurde nicht gefunden."
            }
            return
        }
        
        var users = Set(group.users ?? [])
        
        users.insert(userId)
        
        await db.updateDocument(collection: "groups", documentId: group.id ?? "", data: ["users" : Array(users)])
    }
    
    func generateCode(text: String) -> Data? {
        let data = text.data(using: .ascii, allowLossyConversion: false)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        
        guard let ciimage = filter.outputImage else { return nil }
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        let scaledCIImage = ciimage.transformed(by: transform)
        
        let uiimage = UIImage(ciImage: scaledCIImage)
        
        return uiimage.pngData()
    }
}
