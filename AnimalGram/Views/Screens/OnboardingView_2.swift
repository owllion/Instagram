//
//  OnboardingView_2.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import SwiftUI

struct OnboardingView_2: View {
    @EnvironmentObject var loginViewModel: AuthenticationViewModel

    @State var showImagePicker: Bool = false
    @State var selectedImage: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType  = .photoLibrary
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.yellow)
            
            TextField(
                "",
                text: $loginViewModel.displayName,
                prompt: Text("Add your name here...")
                    .foregroundColor(.gray)
            ).customTextField(background: Color.MyTheme.beige)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Finish: Add Profile picture").customLabel()
                
            }.tint(Color.MyTheme.purple)
                .opacity(loginViewModel.displayName.isEmpty ? 0 : 1 )
                .animation(.easeOut(duration: 1.0), value: loginViewModel.displayName.isEmpty)
            
        }.padding(.all,20)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.MyTheme.purple)
            .edgesIgnoringSafeArea(.all)
//            .sheet(isPresented: $showImagePicker) {
//                loginViewModel.createUser()
//            } content: {
//                ImagePicker(sourceType: $sourceType, imageSelected: )
//            }

    }
    
    //MARK: - CREATE PROFILE FUNCTION
    func createProfile() {
        print("create!")
    }
}

struct OnboardingView_2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView_2()
    }
}
