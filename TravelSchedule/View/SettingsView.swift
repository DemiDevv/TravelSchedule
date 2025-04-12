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

struct SettingsView: View {
    @Binding var errorState: SettingsErrorState
    @State private var isDarkMode = false

    var body: some View {
        VStack(spacing: 0) {
            if errorState == .none {
                // Темная тема — Toggle
                HStack {
                    Text("Темная тема")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                    Spacer()
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                        .tint(.blue)
                }
                .frame(height: 60)
                .padding(.horizontal, 16)

                // Пользовательское соглашение
                RowView(title: "Пользовательское соглашение")

                Spacer()

                // Нижняя подпись
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
            } else {
                // Ошибки: нет интернета или сервер
                Spacer()
                VStack(spacing: 16) {
                    Image(errorState == .noInternet ? "no_internet" : "server_error")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)

                    Text(errorState == .noInternet ? "Нет интернета" : "Ошибка сервера")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.blackYP)
                }
                Spacer()
            }
        }
        .background(Color.white)
    }
}

//#Preview("No Internet") {
//    StatefulPreviewWrapper(SettingsErrorState.noInternet) { state in
//        SettingsViewWrapper(errorState: state)
//    }
//}

//#Preview("Server Error") {
//    StatefulPreviewWrapper(SettingsErrorState.serverError) { state in
//        SettingsViewWrapper(errorState: state)
//    }
//}

#Preview("Normal") {
    StatefulPreviewWrapper(SettingsErrorState.none) { state in
        SettingsViewWrapper(errorState: state)
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

