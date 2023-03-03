//
//  SettingsEditTextView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsEditTextView: View {
    enum SettingsEditTextOption {
        case displayName
        case bio
    }
    
    @StateObject var settingsEditTextViewModel = SettingsEditTextViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    @State var settingsEditTextOption: SettingsEditTextOption
    var userID: String?
    var email: String
    
    
    @Binding var profileText: String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text(description)
                .font(.system(size: 20))
                .padding(.bottom,20)
            
            TextField("",text: $submissionText, prompt:Text(placeholder).foregroundColor(Color.gray)
            )
                .customTextField(background: Color.MyTheme.beige)
            
            Button {
                Task {
                    await self.saveText()
                }
            } label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purple)
                    .cornerRadius(12)
            }.tint(Color.MyTheme.yellow)
            
            Spacer()
            
        }.navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .padding()
            .alert(isPresented: $settingsEditTextViewModel.showAlert) {
                return Alert(title: Text("Saved!"), message: Text(settingsEditTextViewModel.alertMessage), dismissButton: .default(Text("OK")) {
                    self.dismiss()
                }
                )
            }
    }
    
    
    
    @MainActor
    func saveText() async {
        settingsEditTextViewModel.isLoading = true
        switch settingsEditTextOption {
            
        case .bio:
            settingsEditTextViewModel.isLoading = true
            
            self.profileText = submissionText
            
            do {
                try await settingsEditTextViewModel.updateUserBio(email: email, bio: submissionText)
                
                settingsEditTextViewModel.isLoading = false
                settingsEditTextViewModel.handleSuccess(msg: "Successfully change your disaplyName")
                
            }catch {
                settingsEditTextViewModel.isLoading = false
            }
           
            break
            
        case .displayName:
            //authViewModel name
            self.profileText = submissionText
            
            do {
                //all post's displayName
                try await settingsEditTextViewModel.updateDisplayNameOnPosts(userID: userID!, displayName: submissionText)
                
                //user collection's user name
                try await settingsEditTextViewModel.updateUserDisplayName(email: email, newName: submissionText)
                
                settingsEditTextViewModel.isLoading = false
                
                settingsEditTextViewModel.handleSuccess(msg: "Successfully change your bio")

                
            }catch {
                settingsEditTextViewModel.isLoading = false
            }
            
            break
        }
       
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    @State static var test: String = "Test"
    static var previews: some View {
        NavigationView {
            SettingsEditTextView(title: "Test Title", description: "This is description", placeholder: "Teset placeholder", settingsEditTextOption: .displayName, email: "", profileText: $test)

        }
    }
}
