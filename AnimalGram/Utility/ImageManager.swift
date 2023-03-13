//
//  ImageManager.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/24.
//

import Foundation
import FirebaseStorage // holds images and videos

class ImageManager {
    typealias FireBaseUploadResHandler = (String? , Error?) -> Void
    
    //MARK: - Properties
    
    //singleton
    static let instance = ImageManager()
    private var ref = Storage.storage()
    
        
    func downloadImage(path: StorageReference){
       // var finalData: Data?
//        path.getData(maxSize: 27 * 1024 * 1024) { returnedImageData, error in
//            if let data = returnedImageData, let res = UIImage(data: data) {
//                //image = res
//                finalData = data
//
//            } else {
//                print("Error gettgin data from path for image")
//                return
//            }
//        }
//        return finalData!
        
    }

    func uploadProfileImage(userID: String, image: UIImage, done: @escaping (Bool) -> Void) {
        
        //get the path where we will save the image
//        let path = self.getProfileImagePath(userID)
//
//        uploadImageAndGetURL(path: path, image: image) { url, error in
//            if error != nil {
//                done(false)
//            }
//            done()
//
//        }
    }
    
    func uploadPostImage(postID: String, image: UIImage) {
        
//        let path = self.getPostImagePath(postID: postID)
//        print("這是path",path)
//
//        uploadImageAndGetURL(path: path, image: image) { url, error in
//            <#code#>
//
//        }
//
    }
    
    func getProfileImagePath(with userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = ref.reference(withPath: userPath)
        return storagePath
        //return the exact spot where we want our profileImage for this user to be.
    }
    
    func getPostImagePath(with postID: String) -> StorageReference {
        let postPath = "posts/\(postID)/\(UUID().uuidString)"
        let storagePath = ref.reference(withPath: postPath)
        return storagePath
    }
    
    func uploadImageAndGetURL(type: String, id: String, image: UIImage, done: @escaping FireBaseUploadResHandler){
        print()
        
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
        guard let uploadData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            return
        }
        
        //metaData -> what type of file this is
        //Get metaData
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //save data to path
        let path = type == "post" ? self.getPostImagePath(with: id) : self.getProfileImagePath(with: id)
        
        path.putData(uploadData, metadata: metaData)
        { _, error in
            if let error = error {
                print("Error uploading image. \(error)")
                return done(nil, error)
            } else {
                print("upload miage success!")
                
                path.downloadURL { url, error in
                    guard let url = url else {return done(nil, error)}
                    print(url,"this is from imageManager")
                    done(url.absoluteString, nil)
                }
            }
        }
    }
        
    
}
