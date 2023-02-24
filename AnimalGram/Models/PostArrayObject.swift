//
//  PostArrayObject.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import Foundation
import Combine

class PostArrayObject: ObservableObject {
    
    @Published var posts = [PostModel]() //blank array of postModel
    
    
    init() {
        
        posts = [
            .init(postID: "", userID: "", username: "Tim Borton", caption: "", dateCreate: Date(), likeCount: 10, likedByUser: false),
            .init(postID: "", userID: "", username: "Mile Willer", caption: "Stranger Things", dateCreate: Date(), likeCount: 50, likedByUser: false),
            .init(postID: "", userID: "", username: "Dacre Mongmerry", caption: "No Idea Caption", dateCreate: Date(), likeCount: 109, likedByUser: false),
            .init(postID: "", userID: "", username: "Will Buyers", caption: "I am a Gay.", dateCreate: Date(), likeCount:  5002, likedByUser: true)
        ]
    }
    /// use for single post selection
    init(post: PostModel) {
        posts = [post]
    }
}
