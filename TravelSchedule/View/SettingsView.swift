//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(Constants.isDarkMode.stringValue) var isDarkMode: Bool = false
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var externalErrorState: AppError?
    @State private var showingUserAgreement = false
    
    init(errorState: Binding<AppError?>) {
        self._externalErrorState = errorState
    }
    
    var body: some View {
        NavigationView {
            contentView
                .background(isDarkMode ? .blackYP : .whiteYP)
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $showingUserAgreement) {
                    UserAgreementView(tabBarIsHidden: $viewModel.tabBarIsHidden)
                }
        }
        .navigationViewStyle(.stack)
        .onReceive(viewModel.$errorState) { newValue in
            externalErrorState = newValue
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.errorState == nil {
            normalStateView
        } else {
            ErrorView(errors: viewModel.errorState!)
        }
    }
    
    private var normalStateView: some View {
        VStack(spacing: 0) {
            // Настройка темы
            themeSettingRow
            
            // Пользовательское соглашение
            Button(action: {
                showingUserAgreement = true
            }) {
                HStack {
                    Text("Пользовательское соглашение")
                        .font(.system(size: 17))
                        .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .frame(height: 60)
                .padding(.horizontal, 16)
                .background(isDarkMode ? .blackYP : .whiteYP)
            }
            
            Spacer()
            
            // Подпись внизу
            footerInfo
        }
    }
    
    private var themeSettingRow: some View {
        HStack {
            Text("Темная тема")
                .font(.system(size: 17))
                .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
            
            Spacer()
            
            Toggle("", isOn: $isDarkMode)
                .labelsHidden()
                .tint(.blue)
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .background(isDarkMode ? .blackYP : .whiteYP)
    }
    
    private var footerInfo: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12))
                .foregroundColor(isDarkMode ? .white : .blackYP)
                .multilineTextAlignment(.center)

            Text("Версия 1.0 (beta)")
                .font(.system(size: 12))
                .foregroundColor(isDarkMode ? .white : .blackYP)
        }
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
    }
}
