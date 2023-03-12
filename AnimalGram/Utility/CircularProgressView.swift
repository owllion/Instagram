

import SwiftUI

struct CircularProgressView: View {
    @State private var progress = 0.9

       var body: some View {
           Text("Hello")
//           VStack {
//               ProgressView(value: progress)
//                   //.progressViewStyle(.circular)
//                     .scaleEffect(x: 1, y: 2, anchor: .center)
//                     .clipShape(RoundedRectangle(cornerRadius: 6))
//                     .padding(.horizontal)
//
//
//           }
              
       }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
