//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct ErrorView: View {
    private var errors: AppError
    
    init(errors: AppError) {
        self.errors = errors
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
                .foregroundColor(.blackYP)
            Spacer()
        }
    }
}

#Preview {
    ErrorView(errors: AppError.noInternet)
}
