//
//  Comment.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/2.
//

import Foundation

struct Comment : Identifiable {
    var id: String = UUID().uuidString
    var sender: String
    var create_at: Date
}
