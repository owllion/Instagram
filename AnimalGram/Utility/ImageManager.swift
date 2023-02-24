//
//  ImageManager.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/24.
//

import Foundation
import FirebaseStorage // holds images and videos

class ImageManager {
    
    //MARK: - Properties
    
    //singleton
    static let instance = ImageManager()
    private var ref = Storage.storage()
    
    //MARK: - Public functions
    func uploadProfileImage(userID: String) {
        
        //get the path where we will save the image
        let path = self.getProfileImagePath(userID)
        
        //save image to the path
        
    }
    
    //MARK: - Private functions
    private func getProfileImagePath(_ userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = ref.reference(withPath: userPath)
        return storagePath
        //return the exact spot where we want our profileImage for this user to be.
    }
    
}
