//
//  ViewExtension.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//
import SwiftUI

extension View {
    
    func customLabel() -> some View {
            self.font(.headline)
            .fontWeight(.bold)
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.MyTheme.yellow)
            .cornerRadius(12)
            .padding(.horizontal)
    }
    
    func customTextField(background: Color) -> some View {
        self.padding()
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.MyTheme.purple)
        .background(background)
        .cornerRadius(12)
        .font(.headline)
        .textInputAutocapitalization(.sentences)
    }

}

