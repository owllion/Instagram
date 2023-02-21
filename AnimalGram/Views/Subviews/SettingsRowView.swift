//
//  SettingsRowView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/21.
//

import SwiftUI

struct SettingsRowView: View {
    var iconName: String
    var settingName: String
    var iconColor: Color
    
    var body: some View {
        HStack {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(iconColor)
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(settingName)
            Spacer()
           
            Image(systemName: "chevron.right")
            
            
        }
        .padding(.all,6)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(iconName: "snowflake.slash", settingName: "Frozen", iconColor: .blue).previewLayout(.sizeThatFits)
    }
}
