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
        VStack {
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
            
            NavigationView {
                WebView(isDarkMode: $isDarkMode)
                    .edgesIgnoringSafeArea(.all)
                    .background(isDarkMode ? Color.blackYP : Color.whiteYP)
            }
            .navigationBarBackButtonHidden(true)
        }
        .background(isDarkMode ? Color.blackYP : Color.whiteYP)
    }
}

#Preview {
    UserAgreementView(tabBarIsHidden: .constant(true))
}
