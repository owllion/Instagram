//
//  User.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/6.
//

import Foundation

struct User : Identifiable, Hashable {
    var id: String = UUID().uuidString
    var displayName: String
    var imageURL: String
    var email: String
}
