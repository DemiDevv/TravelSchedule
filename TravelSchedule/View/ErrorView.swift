//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct ErrorView: View {
    private var errors: AppError
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    init(errors: AppError) {
        self.errors = errors
    }
    
    private var backgroundColor: Color {
        isDarkMode ? Color.blackYP : Color.white
    }
    
    private var textColor: Color {
        isDarkMode ? .whiteYP : .blackYP
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(errors.type.image)
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            Text(errors.type.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(textColor)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

#Preview {
    ErrorView(errors: AppError.noInternet)
}
