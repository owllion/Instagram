//
//  SignInWithAppleButtonCustom.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import Foundation
import SwiftUI
import AuthenticationServices


//create a apple button
struct SignInWithAppleButtonCustom: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
