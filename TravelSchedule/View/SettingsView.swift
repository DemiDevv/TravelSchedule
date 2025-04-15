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
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var externalErrorState: SettingsErrorState
    
    init(errorState: Binding<SettingsErrorState>) {
        self._externalErrorState = errorState
    }
    
    var body: some View {
        NavigationView {
            contentView
                .background(Color.white)
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
                .foregroundColor(.black)
            Spacer()
            Toggle("", isOn: $viewModel.isDarkMode)
                .labelsHidden()
                .tint(.blue)
                .onChange(of: viewModel.isDarkMode) { _ in
                    viewModel.toggleDarkMode()
                }
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
    }
    
    private var userAgreementRow: some View {
        NavigationLink(
            destination: UserAgreementView(tabBarIsHidden: $viewModel.tabBarIsHidden),
            isActive: $viewModel.showingUserAgreement
        ) {
            RowView(title: "Пользовательское соглашение")
        }
        .simultaneousGesture(TapGesture().onEnded {
            viewModel.showUserAgreement()
        })
    }
    
    private var footerInfo: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12))
                .foregroundColor(.blackYP)
                .multilineTextAlignment(.center)

            Text("Версия 1.0 (beta)")
                .font(.system(size: 12))
                .foregroundColor(.blackYP)
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
                .foregroundColor(.blackYP)
                
            Spacer()
        }
    }
}

// MARK: - Previews

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(SettingsErrorState.none) { state in
                SettingsViewWrapper(errorState: state)
            }
            .previewDisplayName("Normal State")
            
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
