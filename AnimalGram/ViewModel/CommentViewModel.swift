import Foundation
import FirebaseFirestore
import SwiftUI

private let store = Firestore.firestore()

class CommentViewModel : ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var comments: [Comment] = [Comment]()
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var isLoading: Bool = false
    
    
    func handleAlert(_ error: Error, msg: String?) {
        self.alertMessage = msg ?? error.localizedDescription
        self.showAlert.toggle()
    }
    
    func handleAlertMsg(msg: String) {
        self.alertMessage = msg
        self.showAlert = true
    }
    
    @MainActor
    func addComment(postID: String, content: String, imgUrl: String, userName: String ) async throws {
        
        self.isLoading = true
        
        let document = postCollection.document(postID).collection(K.FireStore.Post.Comment.collectionName).document()
        let commentID = document.documentID
        
        let data : [String : Any] = [
            K.FireStore.Post.Comment.commentIDField : commentID,
            K.FireStore.Post.Comment.contentField : content,
            K.FireStore.Post.Comment.userNameField : userName,
            K.FireStore.Post.Comment.userImageURLField : imgUrl,
            K.FireStore.Post.Comment.createdAtField : FieldValue.serverTimestamp()
        ]
        
        do {
            try await document.setData(data)
            self.isLoading = false
            
        }catch {
            self.isLoading = false
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
                            
                                let createdAt = data[K.FireStore.Post.Comment.createdAtField] as? Timestamp
                                
                        {
                            let newComment = Comment(id: UUID().uuidString, userName: userName, userImageURL: userImageURL, content: content, commentID: commentID, likeCount: likeCount, createdAt: createdAt)
                            
                            self.comments.append(newComment)
                        }
                        
                    }
                    self.isLoading = false
                }
    }
    
   
 
    //func textIsAppropriate(_ submissionText: String) -> Bool {
//        print("這是收到的text", submissionText)
//        let badWords : [String] = ["shit", "ass"]
//
//        let words = submissionText.components(separatedBy: " ")
//        //把含空格的字串轉成陣列 並以空格為切割基準
//        print("這是words", words)
//
//        for word in words {
//            if badWords.contains(word) {
//                return false
//            }
//        }
//        if submissionText.count < 3 {
//            return false
//        }
//
//        return true
//    }
}
