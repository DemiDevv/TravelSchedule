//
//  ListOfCarriersView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    let trains: [TrainInfo]
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(isDarkMode ? .whiteYP : .black)
                        .font(.system(size: 20, weight: .bold))
                }

                Spacer()
            }

            Text("Москва (Ярославский вокзал) → Санкт Петербург(Балтийский вокзал)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .padding(16)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(trains) { train in
                        TrainCellView(train: train)
                    }
                }
            }

            Button(action: {}) {
                Text("Уточнить время")
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
        .background(isDarkMode ? Color.blackYP : Color.white)
    }
}

#Preview {
    // Создаем календарь для удобного создания дат
    let calendar = Calendar.current
    let now = Date()
    
    // Функция для создания даты из компонентов
    func createDate(day: Int, hour: Int, minute: Int) -> Date {
        var components = calendar.dateComponents([.year, .month], from: now)
        components.day = day
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components)!
    }
    
    return ListOfCarriersView(trains: [
        TrainInfo(
            companyName: "РЖД",
            companyLogo: Image(systemName: "tram.fill"),
            note: "С пересадкой в Костроме",
            date: createDate(day: 14, hour: 0, minute: 0), // 14 января
            departureTime: createDate(day: 14, hour: 22, minute: 30),
            arrivalTime: createDate(day: 15, hour: 8, minute: 15), // прибытие на следующий день
            duration: 20 * 3600 // 20 часов в секундах
        ),
        TrainInfo(
            companyName: "ФГК",
            companyLogo: Image(systemName: "bolt.car.fill"),
            note: nil,
            date: createDate(day: 15, hour: 0, minute: 0), // 15 января
            departureTime: createDate(day: 15, hour: 1, minute: 15),
            arrivalTime: createDate(day: 15, hour: 9, minute: 0),
            duration: 9 * 3600 // 9 часов в секундах
        ),
        TrainInfo(
            companyName: "Урал логистика",
            companyLogo: Image(systemName: "drop.fill"),
            note: nil,
            date: createDate(day: 16, hour: 0, minute: 0), // 16 января
            departureTime: createDate(day: 16, hour: 12, minute: 30),
            arrivalTime: createDate(day: 16, hour: 21, minute: 0),
            duration: 9 * 3600 // 9 часов в секундах
        ),
        TrainInfo(
            companyName: "РЖД",
            companyLogo: Image(systemName: "tram.fill"),
            note: "С пересадкой в Костроме",
            date: createDate(day: 17, hour: 0, minute: 0), // 17 января
            departureTime: createDate(day: 17, hour: 22, minute: 30),
            arrivalTime: createDate(day: 18, hour: 8, minute: 15), // прибытие на следующий день
            duration: 20 * 3600 // 20 часов в секундах
        )
    ])
}
