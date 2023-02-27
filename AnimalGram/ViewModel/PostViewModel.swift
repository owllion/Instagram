//
//  PostViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore

private let store = Firestore.firestore()

class PostViewModel: ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var posts = [Post]()
    
    //MARK: - Error Properties
    @Published var showPostVMError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        errorMessage = error.localizedDescription
        showPostVMError.toggle()
        
    }
    
    //MARK: - FIrebase CRUD
    
    @MainActor func createPost(_ post: Post) {
        do {
            try postCollection.addDocument(from: post)
        } catch {
            self.handleError(error)
        }
    }
    
    func getSinglePost() {}
    
    func getPosts() {
        postCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                self.showPostVMError.toggle()
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.posts = (snapshot?.documents.compactMap {
                try? $0.data(as: Post.self)
            }) ?? []
        }
    }
    
    func updatePost(_ post: Post) {
        do {
            try postCollection.document(post.postID).setData(from: post)
        } catch {
            self.handleError(error)
        }
    }
    
    func deletePost(_ postId: String) {
        postCollection.document(postId).delete { error in
            if let error = error {
                print("Unable to remove the post: \(error.localizedDescription)")
                self.handleError(error)
            }
            
            
        }
    }
    
    
    
}
