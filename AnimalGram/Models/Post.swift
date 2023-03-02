//
//  PostModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//
import SwiftUI

struct Post: Identifiable, Codable ,Hashable {
    var id: String = UUID().uuidString
    var postID: String
    var userID: String
    var displayName: String
    var caption: String?
    var dateCreated: Int
    var postImageURL: String
    var likeCount: Int
    var likedBy: Array<String>
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        //compare two instance's id
//    }
    
}
