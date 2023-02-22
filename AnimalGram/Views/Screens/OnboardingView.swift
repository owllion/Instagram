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
            
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.purple)
            
            Text("AnimalGram is the #1 app for posting pictures of your animal and sharing them across the world.")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purple)
                .padding()
            
            Button {
                print("Sign up")
            } label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
            
            Button {
                print("Sign up")
            } label: {
                HStack {
                   
                    Image("googleIcon")
                        .frame(maxWidth: 1,maxHeight: 1)
                        .padding(.trailing,5)
                        .padding(.leading,20)
                    
                    Text("Sign in with Google")
                    
                }.frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(9)
                    .font(.system(size: 23, weight: .medium, design: .default))
                    
            }.tint(.gray)

            
        }.padding(.all,20)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.MyTheme.beige)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
