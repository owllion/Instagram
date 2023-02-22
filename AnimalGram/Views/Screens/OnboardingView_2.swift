//
//  OnboardingView_2.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import SwiftUI

struct OnboardingView_2: View {
    @State var displayName: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.yellow)
            
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(width: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beige)
                .cornerRadius(12)
                .font(.headline)
                .textInputAutocapitalization(.sentences)
                .padding(.horizontal)
            
            Button {
                print("ff")
            } label: {
                Text("Finish: Add Profile picture").customLabel()
                
            }
        }.padding(.all,20)
    }
}

struct OnboardingView_2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView_2()
    }
}
