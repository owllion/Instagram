

import SwiftUI

struct CircularProgressDemoView: View {
    @State private var progress = 0.6

       var body: some View {
           VStack {
               ProgressView(value: progress)
                   .progressViewStyle(.circular)
           }
       }
}

struct CircularProgressDemoView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressDemoView()
    }
}
