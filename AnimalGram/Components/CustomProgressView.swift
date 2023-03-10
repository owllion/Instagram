//
//  ProgressView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/10.
//

import SwiftUI

struct CustomProgressView: View {
    
    var placeHolder: String = "Please wait"
    @State var animate: Bool = false
    
    var body: some View {
        
        VStack(spacing: 28) {
            
            Circle()
                .stroke(AngularGradient(gradient: Gradient(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
            
            Text(placeHolder)
                .fontWeight(.bold)
           
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
        ).edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                
                animate.toggle()
            }
        }
    }
}

//backgroundView

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
   
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(placeHolder: "")
    }
}
