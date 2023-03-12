import Foundation
import FirebaseFirestore
import SwiftUI

private let store = Firestore.firestore()

class CommentViewModel : ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var comments: [Comment] = [Comment]()
    @Published var commentsCount: Int = 0
    @Published var animateLike: Bool = false

    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isAddingComment: Bool = false
    
    
    func handleAlert(_ error: Error, msg: String?) {
        self.alertMessage = msg ?? error.localizedDescription
        self.showAlert.toggle()
    }
    
    func handleAlertMsg(msg: String) {
        self.alertMessage = msg
        self.showAlert = true
    }
    
    @MainActor
    func addComment(postID: String, content: String, imgUrl: String, userName: String ) async{
        
        self.isAddingComment = true
        
        let document = postCollection.document(postID).collection(K.FireStore.Post.Comment.collectionName).document()
        let commentID = document.documentID
        
        let data : [String : Any] = [
            K.FireStore.Post.Comment.commentIDField : commentID,
            K.FireStore.Post.Comment.contentField : content,
            K.FireStore.Post.Comment.userNameField : userName,
            K.FireStore.Post.Comment.userImageURLField : imgUrl,
            K.FireStore.Post.Comment.likeCountField : 0,
            K.FireStore.Post.Comment.likeByField : [],
            K.FireStore.Post.Comment.createdAtField : Int(Date().timeIntervalSince1970)
        ]
        
        do {
            try await document.setData(data)
            self.isAddingComment = false
            
        }catch {
            self.isAddingComment = false
            self.handleAlert(error, msg: "Something worng when adding comment to DB")
        }
    }
    
    
    func getComments(postID: String) {
            self.isLoading = true
        
            postCollection
                .document(postID)
                .collection(K.FireStore.Post.Comment.collectionName)
                .order(by: K.FireStore.Post.Comment.createdAtField)
                .limit(to: 50)
                .addSnapshotListener { snapshot, error in
                    
                    self.comments = []
                    
                    if let error = error {
                        self.handleAlert(error, msg: "something wrong when getting comments")
                        return
                    }
                    for doc in snapshot!.documents {
                        let data = doc.data()
                        
                        if
                            let commentID = data[K.FireStore.Post.Comment.commentIDField] as? String,
                            let userName = data[K.FireStore.Post.Comment.userNameField] as? String,
                            let userImageURL = data[K.FireStore.Post.Comment.userImageURLField] as? String,
                            let content = data[K.FireStore.Post.Comment.contentField] as? String,
                            let likeCount = data[K.FireStore.Post.Comment.likeCountField] as? Int,
                            let likeBy = data[K.FireStore.Post.Comment.likeByField] as? Array<String>,
                            
                            let createdAt = data[K.FireStore.Post.Comment.createdAtField] as? Int
                                
                        {
                            let newComment = Comment(id: UUID().uuidString, userName: userName, userImageURL: userImageURL, content: content, commentID: commentID, likeCount: likeCount, likedBy: likeBy, createdAt: createdAt)
                            
                            self.comments.append(newComment)
                        }
                        
                    }
                    self.isLoading = false
                }
    }
    
    @MainActor
    func getCommentsCount(postID: String) async {
        self.isLoading = true
        
        do {
            let snapshot = try await postCollection
                .document(postID)
                .collection(K.FireStore.Post.Comment.collectionName)
                .getDocuments()
            self.commentsCount = snapshot.documents.count
            
            self.isLoading = false
            
        } catch {
            self.isLoading = false
            self.handleAlert(error, msg: nil)
        }
    }
    
    func likePost(postID: String, userID: String, commentID: String) {
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            animateLike = false
        }
        
        let increment: Int64 = 1
        let data: [String: Any] = [
            K.FireStore.Post.Comment.likeCountField : FieldValue.increment(increment) ,
            K.FireStore.Post.Comment.likeByField : FieldValue.arrayUnion([userID])
        ]
        
        postCollection.document(postID).collection(K.FireStore.Post.Comment.collectionName).document(commentID).updateData(data) {
            error in
            if let error = error {
                self.handleAlert(error, msg: nil)
                return
            }
        }
    }
    
    
    func unlikePost(postID: String, userID: String, commentID: String) {
        let increment: Int64 = -1
        let data: [String: Any] = [
            K.FireStore.Post.Comment.likeCountField : FieldValue.increment(increment) ,
            K.FireStore.Post.Comment.likeByField : FieldValue.arrayRemove([userID])
        ]
        
        postCollection.document(postID).collection(K.FireStore.Post.Comment.collectionName).document(commentID).updateData(data) {
            error in
            if let error = error {
                self.handleAlert(error, msg: nil)
                return
            }
        }
    }
    
}
