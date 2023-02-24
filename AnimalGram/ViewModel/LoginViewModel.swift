//
//  GoogleLoginVM.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/23.
//

import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


private let store = Firestore.firestore()

class LoginViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    //MARK: - Data collections
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    
    //MARK: - User data
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var profileImage: UIImage = UIImage(named: "dog1")!
    
    //MARK: - Post data
    @Published var posts = [Post]()

    
    //MARK: - View Properties
    @Published var state: SignInState = .signedOut
    
    //MARK: - Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
//        await MainActor.run(body: {
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
        errorMessage = error.localizedDescription
        showError.toggle()
        
    }
    
    
    //MARK: - google login
    func signIn() {
        //      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        //        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        //            authenticateUser(for: user, with: error)
        //        }
        //      } else {
        
        
        //Must set the clientID to the GIDSignIn or app will crash
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //Start login flow
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController())  { signInResult, error in
            self.authenticateUser(for: signInResult, with: error)
        }
        
    }
    
    //Get user data and store into Firestore
    func authenticateUser(for result: GIDSignInResult?, with error: Error?) {
        
        if let error = error {
            self.handleError(error)
            return
        }
        
        guard let idToken = result?.user.idToken else { return }
        
        let profile = result?.user.profile
        
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,accessToken:(result?.user.accessToken.tokenString)!)
        
        Auth.auth().signIn(with: credential) {
            (_, error) in
                if let error = error {
                    self.handleError(error)
                } else {
                    self.state = .signedIn
                    self.email = profile!.email
                    self.displayName = profile!.name
                    profile!.imageURL(withDimension: 240)
                    self.createUser()
                    
                }
        }
}
    
    func signOut() {
      GIDSignIn.sharedInstance.signOut()
      
      do {
        try Auth.auth().signOut()
        
        state = .signedOut
      } catch {
          self.handleError(error)
      }
    }
    
    //MARK: - Firebase CRUD
    
    func createUser() {
        
        let document = userCollection.document()
        let userID = document.documentID
        
        ImageManager.instance.uploadProfileImage(userID: userID, image: self.profileImage)
        
        
        let userData: [String : Any] = [
            K.FireStore.User.displayNameField : self.displayName,
            K.FireStore.User.emailField : self.email,
            K.FireStore.User.providerID : "",
            K.FireStore.User.provider : "",
            K.FireStore.User.userID : userID,
            K.FireStore.User.bio : "Introduce yourself!",
            K.FireStore.User.dateCreated : Date().timeIntervalSince1970
        ]
        
        userCollection.addDocument(data: userData) { error in
            if let error = error {
                self.handleError(error)
            } else {
                print("Success create!")
            }
        }
               
            
            
    }
    
    func getUser() {
        
    }
    
    func createPost(_ post: Post) {
        do {
            try postCollection.addDocument(from: post)
        } catch {
            self.handleError(error)
            
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

//MARK: - Extensions
extension UIApplication {
    func rootController() -> UIViewController {
        // As you’re not using view controllers to retrieve the presentingViewController, access it through the shared instance of the UIApplication.
        guard let windowScene = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return .init() }
        
        return rootViewController
    }
}
