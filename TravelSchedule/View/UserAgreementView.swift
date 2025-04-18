//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

import SwiftUI

struct UserAgreementView: View {
    @Binding var tabBarIsHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    var body: some View {
        ZStack {
            // Фоновый цвет на весь экран
            (isDarkMode ? Color.blackYP : Color.whiteYP)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Хедер с кнопкой назад
                HStack {
                    Button(action: {
                        dismiss()
                        tabBarIsHidden = false
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                            .font(.system(size: 22))
                            .padding(.leading, 8)
                    }
                    Spacer()
                    Text("Пользовательское соглашение")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .whiteYP : .black)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                // WebView
                WebView(isDarkMode: $isDarkMode)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            tabBarIsHidden = true
        }
    }
}

#Preview {
    UserAgreementView(tabBarIsHidden: .constant(true))
}
