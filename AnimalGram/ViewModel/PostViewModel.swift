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
    
    enum PostConfirmationOption {
        case general,reporting
    }
    
    
    @Published var postImage:UIImage  = UIImage(named: "dog1")!
    @Published var animateLike: Bool = false
    @Published var showConfirmation: Bool  = false
    @Published var dialogType: PostConfirmationOption = .general
    
    //MARK: - Error Properties
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        alertMessage = error.localizedDescription
        showAlert.toggle()
    }
    
    func handleSuccess(_ msg: String) {
        alertMessage = msg
        showAlert.toggle()
    }
    
    
    //MARK: - PostView's methods
    
    func updatePost(with postID: String,and post: Post) {
        do {
            try postCollection.document(postID).setData(from: post)
        } catch {
            self.handleError(error)
        }
    }
    
    func getNewLikedByArray(type: String, with oldArr: Array<String>, userID: String) -> Array<String> {
        
        var likedBy: Array<String> = []
        
        likedBy = oldArr
        if type == "like" {
            likedBy.append(userID)
        } else {
            likedBy.remove(at: getIdIndex(arr: likedBy, userID: userID))
        }
         
        return likedBy
    }
    
    func getIdIndex(arr: Array<String>, userID: String) -> Int {
        return arr.firstIndex(of: userID)!
    }
    
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
        print("updateData下面")
        
        //Update local data
//        let updatedPost = Post(id: UUID().uuidString, postID: post.postID, userID: post.userID, displayName: post.displayName, caption: post.caption, dateCreated: post.dateCreated, postImageURL: post.postImageURL, likeCount: post.likeCount + 1, likedBy: getNewLikedByArray(with: post.likedBy, userID: userID) )
//
//        print("updatePost", updatedPost)
//        //return so that PostView can use it to replace the original post
//        return updatedPost
    }
    
    func unlikePost(post: Post, postID: String, userID: String) {
        
        //Update animation
        self.animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            animateLike = false
        }
        
        //Update db data
        let increment: Int64 = -1
        let data: [String: Any] = [
            K.FireStore.Post.likeCountField : FieldValue.increment(increment) ,
            K.FireStore.Post.likeByField : FieldValue.arrayRemove([userID])
           
        ]
        
        postCollection.document(postID).updateData(data)
        
//        //Update local data
//        let updatedPost = Post(id: UUID().uuidString, postID: post.postID, userID: post.userID, displayName: post.displayName, caption: post.caption, dateCreated: post.dateCreated, postImageURL: post.postImageURL, likeCount: post.likeCount - 1, likedBy: getNewLikedByArray(with: post.likedBy, userID: userID) )
//
//        //return so that PostView can use it to replace the original post
//        return updatedPost
    }
    
    
//    func reportPost(reason: String, postID: String, done: @escaping (_ success: Bool) -> Void) {
//    }
    func reportPost(reason: String) {
        print("fehfie")
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
                self.alertMessage = error
                self.showAlert = true
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
                    self.handleError(error)
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
                self.handleError(error)
            }
            
            
        }
    }
    
    //MARK: - Utility method
    func generatePostIDForCreatingPost() -> String {
        return postCollection.document().documentID
    }
    
    
    
}
