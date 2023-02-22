//
//  LikeAnimationView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//

import SwiftUI

struct LikeAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        ZStack {
            
            Image(systemName: "heart.fill")
                .foregroundColor(Color.red.opacity(0.3))
                .font(.system(size: 60))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.3)
            
            Image(systemName: "heart.fill")
                .foregroundColor(Color.red.opacity(0.6))
                .font(.system(size: 40))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.4)

            
            Image(systemName: "heart.fill")
                .foregroundColor(Color.red.opacity(0.9))
                .font(.system(size: 30))
                .opacity(animate ? 1.0 : 0.0)
                .scaleEffect(animate ? 1.0 : 0.5)
            
        }
        .animation(.easeOut(duration: 0.5), value: animate)
    }
}

struct LikeAnimationView_Previews: PreviewProvider {
    
    @State static var animate: Bool = true
    
    static var previews: some View {
        LikeAnimationView(animate: $animate).previewLayout(.sizeThatFits)
    }
}
