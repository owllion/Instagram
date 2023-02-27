//
//  FeedViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore


private let store = Firestore.firestore()

class FeedViewModel: ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var posts = [Post]()
    
    
    //MARK: - Error Properties
    @Published var showFeedAlert: Bool = false
    @Published var alertMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        alertMessage = error.localizedDescription
        showFeedAlert.toggle()
        
    }
    
    
    
    func getPosts() {
        postCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                
                self.alertMessage = error.localizedDescription
                self.showFeedAlert.toggle()
                return
            }
            
            self.posts = (snapshot?.documents.compactMap {
                try? $0.data(as: Post.self)
            }) ?? []
        }
    }
}
