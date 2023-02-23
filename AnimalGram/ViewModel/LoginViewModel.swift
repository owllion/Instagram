//
//  GoogleLoginVM.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    //MARK: - View Properties
    @Published var state: SignInState = .signedOut
    
    
    //MARK: - google login
    func signIn() {
        
        // if there’s a previous Sign-In. If yes, then restore it. Otherwise, move on to defining the sign-in process.
        //      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        //        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        //            authenticateUser(for: user, with: error)
        //        }
        //      } else {
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController())  { signInResult, error in
            self.authenticateUser(for: signInResult, with: error)
        }
        
    }
    
    func authenticateUser(for result: GIDSignInResult?, with error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let idToken = result?.user.idToken else { return }
        
        
        let user = result?.user
        let emailAddress = user?.profile?.email
        
        let fullName = user?.profile?.name
        let givenName = user?.profile?.givenName
        let familyName = user?.profile?.familyName
        
        print(fullName)
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,accessToken:(result?.user.accessToken.tokenString)!)
        
        Auth.auth().signIn(with: credential) {
            (_, error) in
                if let error = error {
                  print(error.localizedDescription)
                } else {
                  self.state = .signedIn
                }
        }
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
