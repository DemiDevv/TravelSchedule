//
//  ListOfCarriersView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    let trains: [TrainInfo] // это будет приходить с сервера

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding(.leading)
                }

                Spacer()
            }

            Text("Москва (Ярославский вокзал) → Санкт Петербург(Балтийский вокзал)")
                .font(.system(size: 24, weight: .bold))
                .padding(16)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(trains) { train in
                        TrainCellView(train: train)
                    }
                }
            }

            Button(action: {
            }) {
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
    }
}

#Preview {
    ListOfCarriersView(trains: [
        TrainInfo(
            companyName: "РЖД",
            companyLogo: Image(systemName: "tram.fill"),
            note: "С пересадкой в Костроме",
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов"
        ),
        TrainInfo(
            companyName: "ФГК",
            companyLogo: Image(systemName: "bolt.car.fill"),
            note: nil,
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов"
        ),
        TrainInfo(
            companyName: "Урал логистика",
            companyLogo: Image(systemName: "drop.fill"),
            note: nil,
            date: "16 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов"
        ),
        TrainInfo(
            companyName: "РЖД",
            companyLogo: Image(systemName: "tram.fill"),
            note: "С пересадкой в Костроме",
            date: "17 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов"
        )
    ])
}
