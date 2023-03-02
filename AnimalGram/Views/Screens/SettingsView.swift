//
//  SettingsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var bio: String
    @Binding var displayName: String
    
    var body: some View {
        
        //Add navigationView here is because all views we've created so far are within the NavigationView that in the contentView. But this one is the popup,it will not be included in any navigationView,so have to write here directly.
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: - SECTION 1: AnimalGram
                GroupBox {
                    HStack(alignment: .center, spacing: 20) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        Text("AnimalGram is the #1 app for posting pictures of your animal and sharing them across the world. We are a animal-loving community and we're happy to have you!")
                            .font(.footnote)
                    }
                } label: {
                    SettingsLabelView(labelText: "AnimalGram", labelImage: "dot.radiowaves.left.and.right")
                }.padding()
                
                
                //MARK: - SECTION 2: PROFILE
                GroupBox {
                    NavigationLink {
                        SettingsEditTextView(submissionText: displayName, title: "Display Name", description: "You can edit your display name here.", placeholder: "Your displat name here.")
                    } label: {
                        SettingsRowView(iconName: "pencil", settingName: "Display Name", iconColor: Color.MyTheme.purple)
                    }
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: bio, title: "Profile Bio", description: "Your bio is a great place to let other users know a little about you.", placeholder: "Your bio here..")
                    } label: {
                        SettingsRowView(iconName: "text.quote", settingName: "Bio", iconColor: Color.MyTheme.purple)
                    }
                    
                    
                    NavigationLink {
                        SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts.", selectedImage: UIImage(named: "dog4")!)
                    } label: {
                        SettingsRowView(iconName: "photo", settingName: "Profile Picture", iconColor: Color.MyTheme.purple)
                    }
                    
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SettingsRowView(iconName: "figure.walk", settingName: "Sign out", iconColor: Color.MyTheme.purple)
                    }.alert(isPresented: $authViewModel.showError) {
                        Alert(title: Text("Error signing out"))
                    }
                    
                    
                    
                    
                }.padding()
                
                //MARK: - SECTION 3: APPLICATION
                GroupBox {
                    Button {
                         openCustomURL(urlString: "https://forum.gamer.com.tw/C.php?bsn=7650&snA=1024380")
                    } label: {
                        SettingsRowView(iconName: "hand.raised.square.fill", settingName: "Privacy Policy", iconColor: Color.MyTheme.yellow)
                    }
                    
                    
                    Button {
                       openCustomURL(urlString: "https://forum.gamer.com.tw/A.php?bsn=7650")
                    } label: {
                        SettingsRowView(iconName: "eye", settingName: "Terms & Conditions", iconColor: Color.MyTheme.yellow)
                    }
                    
                    Button {
                        openCustomURL(urlString: "https://github.com/owllion")
                    } label: {
                        SettingsRowView(iconName: "globe", settingName: "Animal", iconColor: Color.MyTheme.yellow)
                    }
                    
                } label: {
                    SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                }.padding()
                
                //MARK: - SECTION 4: SIGN OFF
                GroupBox {
                    Text("AnimalGram was made with love.\nAll Rights Reserved\nCool Apps Inc. \n®2023 🐃")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }.padding()
                    .padding(.bottom,70)
                
            }.navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }.tint(Color.primary)
                        
                        
                    }
                }
        }
        
    }
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    @State static var bio: String = ""
    @State static var name: String = ""
    static var previews: some View {
        SettingsView(bio: $bio, displayName: $name)
    }
}
