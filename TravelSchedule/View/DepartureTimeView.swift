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

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(isDarkMode ? .whiteYP : .black)
                        .font(.system(size: 22, weight: .medium))
                }
                .padding(.leading, 8)

                Spacer()
            }
            
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
                // Действие при нажатии
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
    }
}

// MARK: - Custom Checkbox Row (60pt высота)
struct CustomCheckboxRow: View {
    let title: String
    let isSelected: Bool
    let isDarkMode: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                Spacer()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .font(.system(size: 24, weight: .medium))
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Custom Radio Row (60pt высота)
struct CustomRadioRow: View {
    let title: String
    let isSelected: Bool
    let isDarkMode: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .font(.title3)
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Модель времени
enum TimeOption: CaseIterable, Hashable {
    case morning, day, evening, night

    var label: String {
        switch self {
        case .morning: return "Утро 06:00 – 12:00"
        case .day: return "День 12:00 – 18:00"
        case .evening: return "Вечер 18:00 – 00:00"
        case .night: return "Ночь 00:00 – 06:00"
        }
    }
}

#Preview {
    DepartureTimeView()
}
