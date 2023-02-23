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
    
    //MARK: - Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    
    
    //MARK: - Handle Error
    func handleError(error: Error){
//        await MainActor.run(body: {
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
        errorMessage = error.localizedDescription
        showError.toggle()
        
    }
    
    
    //MARK: - google login
    func signIn() {
        //      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        //        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        //            authenticateUser(for: user, with: error)
        //        }
        //      } else {
        
        
        //Must set the clientID to the GIDSignIn or app will crash
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //Start login flow
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController())  { signInResult, error in
            self.authenticateUser(for: signInResult, with: error)
        }
        
    }
    
    //Get user data and store into Firestore
    func authenticateUser(for result: GIDSignInResult?, with error: Error?) {
        
        if let error = error {
            self.handleError(error: error)
            return
        }
        
        guard let idToken = result?.user.idToken else { return }
        

        //let familyName = user?.profile?.familyName
        
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,accessToken:(result?.user.accessToken.tokenString)!)
        
        Auth.auth().signIn(with: credential) {
            (_, error) in
                if let error = error {
                    self.handleError(error: error)
                } else {
                    self.state = .signedIn
                }
        }
}
    
    func signOut() {
      GIDSignIn.sharedInstance.signOut()
      
      do {
        try Auth.auth().signOut()
        
        state = .signedOut
      } catch {
          self.handleError(error: error)
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
