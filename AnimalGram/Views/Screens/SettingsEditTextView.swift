//
//  SettingsEditTextView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsEditTextView: View {
    
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text(description)
            
            TextField(placeholder, text: $submissionText )
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beige)
                .cornerRadius(12)
                .font(.headline)
                .textInputAutocapitalization(.sentences)
            
            Button {
                print("save")
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
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditTextView(title: "Test Title", description: "This is description", placeholder: "Teset placeholder")

        }
    }
}
