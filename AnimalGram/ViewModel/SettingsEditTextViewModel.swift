//
//  SettingsEditTextViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/2.
//

import Foundation
import FirebaseFirestore
import SwiftUI

private let store = Firestore.firestore()

class SettingsEditTextViewModel: ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func handleAlert(_ error: Error, msg: String?) {
        self.alertMessage = msg ?? error.localizedDescription
        self.showAlert.toggle()
    }
    
    func handleSuccess(msg: String) {
        self.alertMessage = msg
        self.showAlert.toggle()

    }
    
    
    func updateUserAvatar(userID: String, imageSelected: UIImage, done: @escaping (String?, Error?) -> ()){
                
        ImageManager.instance.uploadImageAndGetURL(type: "user", id: userID, image: imageSelected) { url, error in
                if let error = error {
                    done(nil, error)
                }
                done(url, nil)
                
        }
        
       
        
    }
    
    func updateUserDisplayName(email: String, newName: String) async throws {
        
        do {
            try await userCollection.document(email).updateData([K.FireStore.User.displayNameField : newName])
            
        }catch {
            self.handleAlert(error, msg: nil)
        }
      
    }
    
    func updateUserBio(email: String, bio: String) async throws {
        
        do {
            try await userCollection.document(email).updateData([K.FireStore.User.bioField : bio])
            
        }catch {
            self.handleAlert(error, msg: nil)
        }
      
    }
    
    func updateDisplayNameOnPosts(userID: String, displayName: String) async throws {
                
        do {
            let snapshot = try await postCollection
                .whereField(K.FireStore.Post.userIDField, isEqualTo: userID).getDocuments()
            for doc in snapshot.documents {
                let docRef = doc.reference
                try await docRef.updateData([K.FireStore.Post.displayNameField : displayName])
            }
        }catch {
            self.handleAlert(error, msg: nil)
        }
    }
}
