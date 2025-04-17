//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

import SwiftUI

enum SettingsErrorState {
    case none
    case noInternet
    case serverError
}

import SwiftUI

struct SettingsView: View {
    @AppStorage(Constants.isDarkMode.stringValue) var isDarkMode: Bool = false
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var externalErrorState: SettingsErrorState
    
    init(errorState: Binding<SettingsErrorState>) {
        self._externalErrorState = errorState
    }
    
    var body: some View {
        NavigationView {
            contentView
                .background(isDarkMode ? .blackYP : .whiteYP)
                .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .onReceive(viewModel.$errorState) { newValue in
            externalErrorState = newValue
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.errorState == .none {
            normalStateView
        } else {
            errorStateView
        }
    }
    
    private var normalStateView: some View {
        VStack(spacing: 0) {
            // Настройка темы
            themeSettingRow
            
            // Пользовательское соглашение
            userAgreementRow
            
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
    
    private var userAgreementRow: some View {
        NavigationLink(
            destination: UserAgreementView(tabBarIsHidden: $viewModel.tabBarIsHidden),
            isActive: $viewModel.showingUserAgreement
        ) {
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
        .simultaneousGesture(TapGesture().onEnded {
            viewModel.showUserAgreement()
        })
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
    
    private var errorStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(viewModel.errorImageName())
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)

            Text(viewModel.errorText())
                .font(.system(size: 24))
                .bold()
                .foregroundColor(isDarkMode ? .white : .blackYP)
                
            Spacer()
        }
        .background(isDarkMode ? Color.black : Color.white)
    }
}

// MARK: - Previews

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(SettingsErrorState.none) { state in
                SettingsViewWrapper(errorState: state)
                    .preferredColorScheme(.light)
            }
            .previewDisplayName("Normal State Light")
            
            StatefulPreviewWrapper(SettingsErrorState.none) { state in
                SettingsViewWrapper(errorState: state)
                    .preferredColorScheme(.dark)
            }
            .previewDisplayName("Normal State Dark")
            
            StatefulPreviewWrapper(SettingsErrorState.noInternet) { state in
                SettingsViewWrapper(errorState: state)
            }
            .previewDisplayName("No Internet")
            
            StatefulPreviewWrapper(SettingsErrorState.serverError) { state in
                SettingsViewWrapper(errorState: state)
            }
            .previewDisplayName("Server Error")
        }
    }
}

struct SettingsViewWrapper: View {
    @Binding var errorState: SettingsErrorState

    var body: some View {
        SettingsView(errorState: $errorState)
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
