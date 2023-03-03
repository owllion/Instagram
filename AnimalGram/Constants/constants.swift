
struct K {
    static let appName = "AnimalGram"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FireStore {
        
        struct User {
            static let collectionName = "users"
            
            //FieldName
            static let displayNameField = "displayName"
            static let emailField = "email"
            static let imageURLField = "imageURL"
            static let userIDField = "userID"
            static let bioField = "bio"
            static let createdAtField = "createdAt"
        }
        
        struct Post {
            static let collectionName = "posts"
            
            //FieldName
            static let postIDField = "postID"
            static let postImageURLField = "postImageURL"
            static let userIDField = "userID"
            static let displayNameField = "displayName"
            static let captionField = "caption"
            static let likeCountField = "likeCount"
            static let likeByField = "likeBy"
            static let commentField = "comments"
            static let createdAtField = "createdAt"
            //sub-collection
            struct Comment {
                //static let userIDField = "userID"
                static let collectionName = "comments"
                
                static let commentIDField = "commentID"
                static let userImageURLField = "userImageURL"
                static let userNameField = "userName"
                static let contentField = "content"
                static let likeCountField = "likeCount"
                static let createdAtField = "createdAt"

            }
        }
        
        struct Report {
            static let collectionName = "reports"
            
            static let postIDField = "postID"
            static let contentField = "content"
            static let createdAtField = "createdAt"
        }
        
        
        
        
    }
}

