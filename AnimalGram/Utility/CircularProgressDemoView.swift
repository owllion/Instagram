

import SwiftUI

struct CircularProgressDemoView: View {
    @State private var progress = 0.9

       var body: some View {
           VStack {
               ProgressView(value: progress)
                   //.progressViewStyle(.circular)
                     .scaleEffect(x: 1, y: 2, anchor: .center)
                     .clipShape(RoundedRectangle(cornerRadius: 6))
                     .padding(.horizontal)
          
                   
           }
              
       }
}

struct CircularProgressDemoView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressDemoView()
    }
}
