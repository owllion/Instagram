//
//  AsyncImageView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/1.
//

import SwiftUI

struct AsyncImageView: View, Equatable {
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            } placeholder: {
                //LottieView(lottieFile: "post-loading")
             
            }
    }

}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "")
    }
}
