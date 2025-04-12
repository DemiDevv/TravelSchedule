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
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Введите запрос", text: $text) { editing in
                isSearching = editing
            } onCommit: {
                isSearching = false
            }
            .foregroundColor(.primary)
            .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

