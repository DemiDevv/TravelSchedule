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
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                    tabBarIsHidden = false
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blackYP)
                        .font(.system(size: 22))
                        .padding(.leading, 8)
                }
                Spacer()
                Text("Пользовательское соглашение")
                    .font(.headline)
                Spacer()
            }
            
            NavigationView {
                WebView(isDarkMode: $isDarkMode)
                    .edgesIgnoringSafeArea(.all)
                    .background(.whiteYP)
            }
            .onAppear {
                isDarkMode = colorScheme == .dark
            }
            .onChange(of: colorScheme) { newScheme in
                isDarkMode = newScheme == .dark
            }
            .navigationBarBackButtonHidden(true)
        }
        .background(.whiteYP)
    }
}

#Preview {
    UserAgreementView(tabBarIsHidden: .constant(true))
}
