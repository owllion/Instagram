//
//  PostModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//
import SwiftUI

struct Post: Identifiable ,Hashable {
    var id: String = UUID().uuidString
    var postID: String
    var userID: String
    var displayName: String
    var caption: String?
    var postImageURL: String
    var userImageURL: String
    var email: String
    var likeCount: Int
    var likedBy: Array<String>
    var createdAt: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) //for comparing pre and cur list item in ForEach is the same or not, it's the same -> not refresh
    }

}
