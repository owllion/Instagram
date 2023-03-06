//
//  LikePostUserListViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/6.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

private let store = Firestore.firestore()

class LikePostUserListViewModel: ObservableObject {
    
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    
    @Published var userList: [User] = [User]()
    
    @Published var isLoading: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func handleError(_ error: Error) {
        self.alertMessage = error.localizedDescription
        self.showAlert.toggle()
    }
    
    
    
    @MainActor
    func getUsers(postID: String)  async throws {
        self.isLoading = true
        
        do {
            let snapshot = try await postCollection
                .whereField(K.FireStore.Post.postIDField, isEqualTo: postID)
                .getDocuments()
            
            if let postInfo = snapshot.documents.first {
                let likeByList = postInfo.data()[K.FireStore.Post.likeByField] as? Array<String>
                
                
                self.userList = []
                
                for id in likeByList! {
                    let snapshot = try await userCollection.whereField(K.FireStore.User.userIDField, isEqualTo: id)
                        .getDocuments()
                    
                    if let doc = snapshot.documents.first {
                        
                        let userInfo = doc.data()
                        
                        let userInstance = User(
                            id: UUID().uuidString,
                            displayName: userInfo[K.FireStore.User.displayNameField] as! String,
                            imageURL: userInfo[K.FireStore.User.imageURLField] as! String,
                            email: userInfo[K.FireStore.User.emailField] as! String
                        )
                        
                        self.userList.append(userInstance)
                    }
                }
            }
          
            self.isLoading = false
            
        }catch {
            self.isLoading = false
            print(error.localizedDescription)
            self.handleError(error)
        }
        
    }
}
