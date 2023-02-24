//
//  AnimalGramRepository.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


//have to decalre here or will get the error
private let store = Firestore.firestore()

//listen to the repo
final class AnimalGramRepository: ObservableObject {
    @StateObject var loginViewModel = LoginViewModel()
    
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    private var userCollection = store.collection(K.FireStore.User.collectionName)

    
    @Published var posts = [Post]()
    
    //MARK: - Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    
    func createUser() {
        let userData: [String : Any] = [
            K.FireStore.User.displayNameField : loginViewModel.$displayName,
            K.FireStore.User.emailField : loginViewModel.$email,
            K.FireStore.User.providerID : "0",
            K.FireStore.User.provider : "google",
            K.FireStore.User.userID : UUID(),
            K.FireStore.User.bio : "",
            K.FireStore.User.dateCreated : Date().timeIntervalSince1970
        ]
        
        userCollection.addDocument(data: userData) { error in
            if let error = error {
                self.showError.toggle()
                self.errorMessage = error.localizedDescription
            } else {
                print("Success create!")
            }
        }
               
            
            
    }
    
    func getPosts() {
        postCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                self.showError.toggle()
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.posts = (snapshot?.documents.compactMap {
                try? $0.data(as: Post.self)
            }) ?? []
        }
    }
    
}
