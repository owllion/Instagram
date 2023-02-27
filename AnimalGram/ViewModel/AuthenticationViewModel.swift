
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
                await getUserID(with: self.email)
                print(self.userID,"This is userID")
                self.state = .signedIn
            } else {
                self.createUser()
                self.state = .signedIn
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
    func getUserID(with email: String) async {
        do {
            let document = try await userCollection.document(email).getDocument()
            
            print(document.get(K.FireStore.User.userIDField),"This is doc.get")
            
            self.userID = document.get(K.FireStore.User.userIDField) as? String
            
        }catch {
            self.handleError(error)
        }
    }
    
    func createUser() {
        let id = generateUserIDForCreatingUserData()
        
        self.userID = id
        
        let userData: [String : Any] = [
            K.FireStore.User.displayNameField : displayName,
            K.FireStore.User.emailField : email,
            K.FireStore.User.imageURLField: imageURL ,
            K.FireStore.User.userIDField : id,
            K.FireStore.User.bioField : "Introduce yourself!",
            K.FireStore.User.dateCreated : Date().timeIntervalSince1970
        ]
        
        userCollection.document(self.email).setData(userData)
        print("Successfullt create user")
//        userCollection.addDocument(data: userData) { error in
//            if let error = error {
//                self.handleError(error)
//                return
//            } else {
//                print("Success create user")
//                self.state = .signedIn
//                //UserDefaults.standard.set(true, forKey: "isLoggedIn")
//            }
//        }
    }
    
    
    
    //MARK: - Utility method
    func getConvertedURL(_ url: URL) -> String {
        return url.absoluteString
        
    }
    
    func generateUserIDForCreatingUserData() -> String {
        return userCollection.document().documentID
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
