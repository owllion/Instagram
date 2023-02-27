//
//  ProfileViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import SwiftUI
import FirebaseFirestore

private let store = Firestore.firestore()

class ProfileViewModel: ObservableObject {
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    
    //MARK: - User data
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var bio: String = ""
    @Published var imageURL: String = ""
    @Published var userID: String?
    @Published var userPosts: [Post] = [Post]()
    //get id from authentiVM -> pass in method -> get data -> assign to this vm's properties -> profile page detect -> re-rendered
    
    //MARK: - Error Properties
    @Published var showUserVMError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        errorMessage = error.localizedDescription
        showUserVMError.toggle()
    }
    
    
    func getSinglePost(with postID: String) {
        
    }
    
}
