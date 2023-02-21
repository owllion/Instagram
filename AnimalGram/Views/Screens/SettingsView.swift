//
//  SettingsView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
                        Text("WoW!")
                    } label: {
                        SettingsRowView(iconName: "pencil", settingName: "Display Name", iconColor: Color.MyTheme.purple)
                    }

                   
                    
                    SettingsRowView(iconName: "text.quote", settingName: "Bio", iconColor: Color.MyTheme.purple)
                    
                    SettingsRowView(iconName: "figure.walk", settingName: "Sign out", iconColor: Color.MyTheme.purple)
                } label: {
                    SettingsLabelView(labelText: "Profile", labelImage: "person.fill")
                }.padding()
                
                //MARK: - SECTION 3: APPLICATION
                GroupBox {
                    SettingsRowView(iconName: "hand.raised.square.fill", settingName: "Privacy Policy", iconColor: Color.MyTheme.yellow)
                    
                    SettingsRowView(iconName: "eye", settingName: "Terms & Conditions", iconColor: Color.MyTheme.yellow)
                    
                    SettingsRowView(iconName: "globe", settingName: "Animal", iconColor: Color.MyTheme.yellow)
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
                        }.tint(Color.MyTheme.purple)
                            

                    }
                }
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
