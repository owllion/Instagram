//
//  ViewExtension.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import Foundation
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
}
