import Foundation
import FirebaseFirestore
import SwiftUI

private let store = Firestore.firestore()

class CommentViewModel : ObservableObject {
    private var postCollection = store.collection(K.FireStore.Post.collectionName)
    
    @Published var comments: [Comment] = [Comment]()
    
    
    
    func addComment(postID: String, content: String, imgUrl: String, userName: String ) {
        
    }
    
    
    func getCommentList(postID: String) {
        
    }
 
    func textIsAppropriate(_ submissionText: String) -> Bool {
        
        let badWords : [String] = ["shit", "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        //把含空格的字串轉成陣列 並以空格為切割基準
        
        for word in words {
            if badWords.contains(word) {
                return false
            }
        }
        if submissionText.count < 3 {
            return false
        }
        
        return true
    }
}
