//
//  PostViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/27.
//

import Foundation
import FirebaseFirestore
import SwiftUI

private let store = Firestore.firestore()

class PostViewModel: ObservableObject {
    
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    private var reportCollection = store.collection(K.FireStore.Report.collectionName)
    
    enum PostConfirmationOption {
        case general,reporting
    }
    
    
    @Published var postImage:UIImage  = UIImage(named: "dog1")!
    @Published var animateLike: Bool = false
    @Published var showConfirmation: Bool  = false
    @Published var dialogType: PostConfirmationOption = .general
    
    @Published var isLoading: Bool = false
    
    //MARK: - Error Properties
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error, msg: String?){
        alertMessage = msg ?? error.localizedDescription
        showAlert.toggle()
    }
    
    func handleSuccess(_ msg: String) {
        alertMessage = msg
        showAlert.toggle()
    }
    
    
    //MARK: - PostView's methods
    
    func likePost(post:Post, postID: String, userID: String){
        //Update animation
        self.animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            animateLike = false
        }
        
        //Update db data
        let increment: Int64 = 1
        let data: [String: Any] = [
            K.FireStore.Post.likeCountField : FieldValue.increment(increment) ,
            K.FireStore.Post.likeByField : FieldValue.arrayUnion([userID])
            //FiledValue -> Firebase's method
            //union -> pass in an arr to cur arr
        ]
        
        postCollection.document(postID).updateData(data) {
            error in
            if let error = error {
                print("這是error",error)
                return
            }
        }
    }
    
    func unlikePost(post: Post, postID: String, userID: String) {
        
        //Update animation
//        self.animateLike = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
//            animateLike = false
//        }
        
        //Update db data
        let increment: Int64 = -1
        let data: [String: Any] = [
            K.FireStore.Post.likeCountField : FieldValue.increment(increment) ,
            K.FireStore.Post.likeByField : FieldValue.arrayRemove([userID])
           
        ]
        
        postCollection.document(postID).updateData(data)
    }
    
    @MainActor
    func reportPost(reason: String, postID: String) async throws  {
        self.isLoading = true
        let data: [String : Any] = [
            K.FireStore.Report.contentField : reason,
            K.FireStore.Report.postIDField : postID,
            K.FireStore.Report.dateCreated : FieldValue.serverTimestamp()
        ]
        
        do {
            try await reportCollection.addDocument(data: data)
            
            self.dialogType = .general
            
            self.handleSuccess("Thanks for reporting this post. We will review it shortly and take the appropriate action!")
            self.isLoading = false

        }catch {
            self.isLoading = false
            
            self.handleError(error, msg: "Error! There was an error uploading the report. Please restart the app and try again.")
        }
    }
   
    func sharePost(_ post: Post) {
        let defaultText = "Just checking in at \(post.displayName)'s post"
        
        //let image = post.postImage
        let image = Image("dog1")
        let link = URL(string: "https://www.youtube.com/watch?v=x5ZeAfz4G3s&list=RDx5ZeAfz4G3s&start_radio=1")!
        
        let activityViewController = UIActivityViewController(activityItems:[defaultText,image,link], applicationActivities: nil)
        
        //get the background view controller
        //grabbing the first key window that is found in the whole application,
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }

        let viewController = firstWindow.rootViewController
        
        viewController?.present(activityViewController, animated: true, completion: nil)
    }

    func createPost(with caption: String, and image: UIImage, by userID: String, named userName: String) {
        
        let postID = generatePostIDForCreatingPost()
        
        ImageManager.instance.uploadImageAndGetURL(type: "post", id: postID, image: image) { [self] url, error in
            if let error = error {
                self.handleError(error, msg: nil)
            }
            let postData: [String: Any] = [
                K.FireStore.Post.postIDField: postID,
                K.FireStore.Post.userIDField: userID,
                K.FireStore.Post.displayNameField: userName,
                K.FireStore.Post.postImageURLField: url! as String,
                K.FireStore.Post.captionField: caption,
                K.FireStore.Post.dateCreated: Int(Date().timeIntervalSince1970),
                K.FireStore.Post.likeCountField: 0,
                K.FireStore.Post.likeByField: []
            ]
            
            postCollection.document(postID).setData(postData) { error in
                if let error = error {
                    self.handleError(error, msg: nil)
                    return
                } else {
                    print("Successfully post!")
                    self.handleSuccess("Successfully post!")
                }
            }
            
        }
        
        
    }
    
    
    func deletePost(_ postID: String) {
        postCollection.document(postID).delete { error in
            if let error = error {
                print("Unable to remove the post: \(error.localizedDescription)")
                self.handleError(error, msg: nil)
            }
            
            
        }
    }
    
    //MARK: - Utility method
    func generatePostIDForCreatingPost() -> String {
        return postCollection.document().documentID
    }
    
    
    
}
