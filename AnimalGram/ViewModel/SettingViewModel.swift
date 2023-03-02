//
//  SettingViewModel.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/2.
//

import Foundation

class SettingViewModel: ObservableObject {
    enum SettingsEditTextOption {
        case displayName
        case bio
    }
    
    func saveText(type: SettingsEditTextOption) {
        switch type {
        case .bio:
            break
        case .displayName:
            //post/ autheVM's displayName
            break
        }
       
    }
}
