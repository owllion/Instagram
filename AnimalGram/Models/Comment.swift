//
//  Comment.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/2.
//

import Foundation
import FirebaseFirestore

struct Comment : Identifiable, Hashable {
    var id: String = UUID().uuidString
    var userName: String
    var userImageURL: String
    var content: String
    var commentID: String
    var likeCount: Int
    var likedBy: Array<String>
    var createdAt: Int
   
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
