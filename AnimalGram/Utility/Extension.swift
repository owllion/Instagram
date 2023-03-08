//
//  ViewExtension.swift
//  AnimalGram
//
//  Created by Zheng yu hsin on 2023/2/22.
//
import SwiftUI
import Foundation

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, @ViewBuilder _ content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<Truthy: View, Falsy: View>(_ conditional: Bool = true, @ViewBuilder _ truthy: (Self) -> Truthy, @ViewBuilder else falsy: (Self) -> Falsy) -> some View {
        if conditional {
            truthy(self)
        } else {
            falsy(self)
        }
    }

    
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
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MMMM d"
        
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
    
    
    
    func isInWeek() -> Bool {
        let now = Date.now
        let fromDate = Calendar.current.date(byAdding: .day, value:  -7, to: now)!
        let range = fromDate...now
        
        return range.contains(self)
       
    }
    
}

extension Double {
    var kmFormatted: String {

        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }

        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current,self)
    }
}



