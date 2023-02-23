//
//  AnimalGramRepository.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


//listen to the repo
final class AnimalGramRepository: ObservableObject {
    private let store = Firestore.firestore()
    
    @Published var posts = [PostModel]()
    
    
}
