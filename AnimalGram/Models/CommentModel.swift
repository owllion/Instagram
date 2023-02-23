//
//  CommentModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import Foundation

struct CommentModel: Identifiable, Hashable {
    var id = UUID()
    var commentID: String
    var userID: String
    var username: String
    var content: String
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        //compare instace with id
    }
}
