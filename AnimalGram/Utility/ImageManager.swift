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
    func uploadProfileImage(userID: String, image: UIImage) {
        
        //get the path where we will save the image
        let path = self.getProfileImagePath(userID)
        
        //save image to the path
        uploadImage(path: path, image: image)
        
    }
    
    func uploadPostImage(postID: String, image: UIImage) {
        
        let path = getPostImagePath(postID: postID)
        
        uploadImage(path: path, image: image)
        
    }
    
    //MARK: - Private functions
    private func getProfileImagePath(_ userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = ref.reference(withPath: userPath)
        return storagePath
        //return the exact spot where we want our profileImage for this user to be.
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "posts/\(postID)/1"
        let storagePath = ref.reference(withPath: postPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference,image: UIImage) {
        
        var compression: CGFloat = 1.0
        let maxFileSize:Int = 240 * 240 //Maximum file size that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum comporession we ever allow
        
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            return
        }
        
        
        //check maximum file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressionData = image.jpegData(compressionQuality: compression) {
                originalData = compressionData
            }
            print(compression)
        }
        
        
        //get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            return
        }
        
        //metaData -> what type of file this is
        //Get metaData
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //save data to path
        path.putData(finalData, metadata: metaData)
        { _, error in
            if let error = error {
                print("Error uploading image. \(error)")
            } else {
                print("upload miage success!")
            }
        }
    }
    
    
    
        
    
}
