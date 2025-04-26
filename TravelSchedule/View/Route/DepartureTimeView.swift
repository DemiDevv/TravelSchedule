//
//  DepartureTimeView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct DepartureTimeView: View {
    @State private var selectedTimes: Set<TimeOption> = [.morning, .night]
    @State private var withTransfers: Bool? = false
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            // MARK: Время отправления
            VStack(alignment: .leading, spacing: 0) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .padding(.bottom, 8)

                ForEach(TimeOption.allCases, id: \.self) { option in
                    CustomCheckboxRow(
                        title: option.label,
                        isSelected: selectedTimes.contains(option),
                        isDarkMode: isDarkMode
                    ) {
                        if selectedTimes.contains(option) {
                            selectedTimes.remove(option)
                        } else {
                            selectedTimes.insert(option)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)

            // MARK: Пересадки
            VStack(alignment: .leading, spacing: 0) {
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .padding(.bottom, 8)

                CustomRadioRow(
                    title: "Да",
                    isSelected: withTransfers == true,
                    isDarkMode: isDarkMode
                ) {
                    withTransfers = true
                }

                CustomRadioRow(
                    title: "Нет",
                    isSelected: withTransfers == false,
                    isDarkMode: isDarkMode
                ) {
                    withTransfers = false
                }
            }
            .padding(.horizontal, 16)

            Spacer()

            Button(action: {
                dismiss() // Закрываем экран при нажатии
            }) {
                Text("Применить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 60)
            .background(Color.blueYP)
            .cornerRadius(16)
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .padding(.top, 16)
        .background(isDarkMode ? Color.blackYP : Color.whiteYP)
        .navigationBarBackButtonHidden(true) // Скрываем стандартную кнопку
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.system(size: 22, weight: .medium))
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DepartureTimeView()
}
