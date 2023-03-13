//
//  ExitButtonView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/12.
//

import SwiftUI

struct ExitButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(white: colorScheme == .dark ? 0.19 : 0.93))
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .font(Font.body.weight(.bold))
                .scaleEffect(0.416)
                .foregroundColor(Color(white: colorScheme == .dark ? 0.62 : 0.51))
        }
    }
}

struct ExitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ExitButtonView()
    }
}
