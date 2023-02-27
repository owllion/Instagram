
import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


private let store = Firestore.firestore()

class AuthenticationViewModel: ObservableObject {
    enum LoginError: Error {
        case userCancel(String)
    }
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    //MARK: - Data collection
    private var userCollection = store.collection(K.FireStore.User.collectionName)
    
    //MARK: - User data
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var bio: String = ""
    @Published var imageURL: String = ""
    @Published var userID: String?
    
    //MARK: - View Properties
    @Published var state: SignInState = .signedOut
    
    //MARK: - Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: - Handle Error
    func handleError(_ error: Error){
        //        await MainActor.run(body: {
        //            errorMessage = error.localizedDescription
        //            showError.toggle()
        //        })
        errorMessage = error.localizedDescription
        showError.toggle()
        
    }
    
    
    //MARK: - google login
    @MainActor
    func signIn() async throws {
        //Must set the clientID to the GIDSignIn or app will crash
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        do {
            //Start login flow
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController())
            await self.authenticateUser(for: result)
            
            
            let userInDB = await self.checkIfUserExistsInDB(with: self.email)
            
            if userInDB {
                self.state = .signedIn
            } else {
                self.state = .signedIn
                self.createUser()
            }
            
        }catch {
            self.handleError(error)
            throw LoginError.userCancel("user cancel the login flow.")
        }
    }
    
    //Get user data and store into Firestore
    @MainActor
    func authenticateUser(for result: GIDSignInResult?) async {
        
        guard let idToken = result?.user.idToken else { return }
        let profile = result?.user.profile
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken.tokenString,
            accessToken: (result?.user.accessToken.tokenString)!
        )
        
        do {
            try await Auth.auth().signIn(with: credential)
            
            self.state = .signedIn
            self.email = profile!.email
            self.displayName = profile!.name
            
            if profile!.hasImage {
                self.imageURL = getConvertedURL(profile!.imageURL(withDimension: 240)!)
            } else {
                self.imageURL = "https://res.cloudinary.com/azainseong/image/upload/v1662517415/mij3ogxe5cqxitevri9z.png"
            }
        }catch {
            self.handleError(error)
        }
    }
    
    @MainActor func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            //UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            state = .signedOut
            print("log out successfully")
        } catch {
            self.handleError(error)
        }
    }
    
    @MainActor func checkIfUserExistsInDB(with email: String) async -> Bool {
        do {
            let snapshot = try await userCollection.whereField(K.FireStore.User.emailField, isEqualTo: email).getDocuments()
            return snapshot.count > 0 ? true : false
            
            
        }catch {
            print("check user error")
            self.handleError(error)
        }
        return false
        
    }
    
    @MainActor
    func getUserData(with userID: String) async {
        do {
            let document = try await userCollection.document(userID).getDocument()
            
            let displayName = document.get(K.FireStore.User.displayNameField) as? String
            let bio = document.get(K.FireStore.User.displayNameField) as? String
            
//            self.displayName = displayName!
//            self.bio = bio!
            
        }catch {
            self.handleError(error)
        }
    }
    
    func createUser() {
        //
        //        ImageManager.instance.uploadProfileImage(userID: self.userID!, image: selectedImage)
        
        self.generateUserIDForCreatingUserData()
        
        let userData: [String : Any] = [
            K.FireStore.User.displayNameField : self.displayName,
            K.FireStore.User.emailField : self.email,
            K.FireStore.User.imageURLField: self.imageURL ,
            K.FireStore.User.userIDField : self.userID!,
            K.FireStore.User.bioField : "Introduce yourself!",
            K.FireStore.User.dateCreated : Date().timeIntervalSince1970
        ]
        
        print(userData,"This is user data")
        
        userCollection.addDocument(data: userData) { error in
            if let error = error {
                self.handleError(error)
                return
            } else {
                print("Success create user")
                self.state = .signedIn
                //UserDefaults.standard.set(true, forKey: "isLoggedIn")
            }
        }
    }
    
    
    
    //MARK: - Utility method
    func getConvertedURL(_ url: URL) -> String {
        return url.absoluteString
        
    }
    
    func generateUserIDForCreatingUserData() {
        let document = userCollection.document()
        self.userID = document.documentID
    }
    
}

//MARK: - Extensions
extension UIApplication {
    func rootController() -> UIViewController {
        // As you’re not using view controllers to retrieve the presentingViewController, access it through the shared instance of the UIApplication.
        guard let windowScene = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return .init() }
        
        return rootViewController
    }
}