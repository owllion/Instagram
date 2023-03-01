
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
            static let dateCreated = "dateCreated"
        }
        
        struct Post {
            static let collectionName = "posts"
            
            //FieldName
            static let postIDField = "postID"
            static let postImageURLField = "postImageURL"
            static let userIDField = "userID"
            static let displayNameField = "displayName"
            static let captionField = "caption"
            static let dateCreated = "dateCreated"
            static let likeCountField = "likeCount"
            static let likeByField = "likeBy"
        }
        
        
    }
}

