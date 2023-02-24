//
//  PostModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//
import SwiftUI

struct Post: Identifiable, Decodable ,Hashable {
    var id = UUID()
    var postID: String
    var userID: String
    var username: String
    var caption: String?
    var dateCreate: Date
    var likeCount: Int
    var likedByUser: Bool
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        //compare two instance's id
//    }
    
}
