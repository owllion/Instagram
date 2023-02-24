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
    private var postCollection = store.collection("posts")
    
    @Published var posts = [PostModel]()
    
    //MARK: - Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    func getPosts() {
        store.collection(K.FireStore.Post.collectionName).addSnapshotListener { snapshot, error in
            if let error = error {
                self.showError.toggle()
                self.errorMessage = error.localizedDescription
            }
            self.posts = (snapshot?.documents.compactMap {
                try? $0.data(as: PostModel.self)
            }) ?? []
        }
    }
    
}
