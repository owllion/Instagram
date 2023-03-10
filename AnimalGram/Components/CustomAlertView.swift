//
//  CustomAlertView.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/3/10.
//

import SwiftUI

struct CustomAlertView: View {
    
    @State var showAlert = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func alertView() {
        let alert = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView()
    }
}
