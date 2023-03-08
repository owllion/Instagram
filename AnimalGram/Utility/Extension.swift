//
//  ViewExtension.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//
import SwiftUI
import Foundation

extension View {
    func customLabel() -> some View {
            self.font(.headline)
            .fontWeight(.bold)
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.MyTheme.yellow)
            .cornerRadius(12)
            .padding(.horizontal)
    }
    
    func customTextField(background: Color) -> some View {
        self.padding()
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.MyTheme.purple)
        .background(background)
        .cornerRadius(12)
        .font(.headline)
        .textInputAutocapitalization(.sentences)
    }

}
extension TimeInterval {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
        
    }
    func toDateString() -> String {
        let date = Date(timeIntervalSince1970: self)
           let dateFormatter = DateFormatter()
           dateFormatter.timeStyle = DateFormatter.Style.medium
           dateFormatter.dateStyle = DateFormatter.Style.medium
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}


