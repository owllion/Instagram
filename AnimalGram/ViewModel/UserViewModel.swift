//
//  UserViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore


private let store = Firestore.firestore()

class UserViewModel: ObservableObject {
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    
    //MARK: - Error Properties
    @Published var showUserVMError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        //        await MainActor.run(body: {
        //            errorMessage = error.localizedDescription
        //            showError.toggle()
        //        })
        errorMessage = error.localizedDescription
        showUserVMError.toggle()
    }
    
    
    @MainActor
    func getUserData(with userID: String) async {
        do {
            let document = try await userCollection.document(userID).getDocument()
            
            let displayName = document.get(K.FireStore.User.displayNameField) as? String
            let bio = document.get(K.FireStore.User.displayNameField) as? String
            
//            self.displayName = displayName!
//            self.bio = bio!
            
        }catch {
            self.handleError(error)
        }
    }
}
