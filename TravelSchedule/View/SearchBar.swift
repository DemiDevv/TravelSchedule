//
//  SearchBar.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(isDarkMode ? .gray : .gray)
            
            ZStack(alignment: .leading) {
                if text.isEmpty && !isFocused {
                    Text("Введите запрос")
                        .foregroundColor(isDarkMode ? .gray : .gray)
                }
                
                TextField("", text: $text) { editing in
                    isSearching = editing
                    isFocused = editing
                } onCommit: {
                    isSearching = false
                    isFocused = false
                }
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .disableAutocorrection(true)
            }
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(isDarkMode ? .gray : .gray)
                }
            }
        }
        .padding(10)
        .background(isDarkMode ? Color.gray.opacity(0.2) : Color(.systemGray6))
        .cornerRadius(12)
    }
}
