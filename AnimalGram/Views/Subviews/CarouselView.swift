//
//  CarouselView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/20.
//

import SwiftUI

struct CarouselView: View {
    
    @State var selection:Int = 0
    private let maxCount: Int = 8
    
    @State var timerAdded: Bool = false
    
    var body: some View {
        
        TabView(selection: $selection) {
            ForEach(1..<self.maxCount, id:\.self) { count in
                Image("dog\(count)")
                    .resizable()
                    .scaledToFill()
                    .tag(count)
            }
            
        }.tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            .animation(.easeInOut, value: 0.5)
            .onAppear {
                if !timerAdded {
                    addTimer()
                }
            }
    }
    func addTimer() {
        
        timerAdded = true
        
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            if selection == (maxCount - 1) {
                selection = 1
                //coz for loop start from 1
            } else {
                selection += 1
            }
        }
        
        timer.fire()
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView().previewLayout(.sizeThatFits)
    }
}
