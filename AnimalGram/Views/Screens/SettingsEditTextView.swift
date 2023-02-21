//
//  SettingsEditTextView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsEditTextView: View {
    @State var submissionText: String = ""
    
    var body: some View {
        VStack {
            
            Text("This is the description so that we can tell the user what they're doing on this screen.")
            
            TextField("PlaceHolder", text: $submissionText )
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
            
        }.navigationTitle("Edit Display Name")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsEditTextView()

        }
    }
}
