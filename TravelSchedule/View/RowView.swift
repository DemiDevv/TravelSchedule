//
//  RowView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RowView: View {
    let title: String
    var showChevron: Bool = true
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if showChevron {
                Spacer()
                Image("RowImage")
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    RowView(title: "Москва")
}
