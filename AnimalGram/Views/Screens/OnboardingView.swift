//
//  OnboardingView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("You are not signed in!")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                //downsize the font if it needs to be downsized to fit the one line.
                .foregroundColor(Color.MyTheme.purple)
            
            Text("Click the button below to create an acount and join the fun!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Button {
                print("Sign up")
            } label: {
                Text("Sign in / Sign up".uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purple)
                    .cornerRadius(12)
                    .shadow(radius: 7)
                    
            }.tint(Color.MyTheme.yellow)

            
        }.padding(.all,40)
       
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
