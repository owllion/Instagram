//
//  SettingsLabelView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsLabelView: View {
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
        VStack {
            
            HStack {
                Text(labelText)
                Spacer()
                Image(systemName: labelImage)
            }
            Divider()
                .padding(.vertical,4)
           
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Test Label", labelImage: "xmark").previewLayout(.sizeThatFits)
    }
}
