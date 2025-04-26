//
//  ListOfCarriersView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    let routeInfo: RouteInfo
    let trains: [TrainInfo]
    
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    @State private var showingDepartureTimeView = false
    @Environment(\.dismiss) private var dismiss
    
    private var routeTitle: String {
        let fromText = "\(routeInfo.fromCity?.name ?? "") (\(routeInfo.fromStation?.name ?? ""))"
        let toText = "\(routeInfo.toCity?.name ?? "") (\(routeInfo.toStation?.name ?? ""))"
        return "\(fromText) → \(toText)"
    }
    
    var body: some View {
        contentView
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showingDepartureTimeView) {
                DepartureTimeView()
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.system(size: 22, weight: .medium))
                    }
                }
            }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(routeTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(isDarkMode ? .whiteYP : .black)
            
            if trains.isEmpty {
                Spacer()
                Text("Вариантов нет")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .black)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(trains) { train in
                            TrainCellView(train: train)
                        }
                    }
                }
            }

            Button(action: { showingDepartureTimeView = true }) {
                Text("Уточнить время")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 60)
            .background(Color.blueYP)
            .cornerRadius(16)
            .padding(.top, 8)
        }
        .padding(16) // ВАЖНО: отступ от ВСЕХ краёв
        .background(isDarkMode ? Color.blackYP : Color.white)
    }
}

// MARK: - Preview
#Preview {
    let mockRouteInfo = RouteInfo(
        fromCity: City(name: "Москва", stations: [Station(name: "Ярославский вокзал")]),
        fromStation: Station(name: "Ярославский вокзал"),
        toCity: City(name: "Санкт-Петербург", stations: [Station(name: "Балтийский вокзал")]),
        toStation: Station(name: "Балтийский вокзал")
    )
    
    let calendar = Calendar.current
    let now = Date()
    
    func createDate(day: Int, hour: Int, minute: Int) -> Date {
        var components = calendar.dateComponents([.year, .month], from: now)
        components.day = day
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components)!
    }
    
    let mockTrains = [
        TrainInfo(
            companyName: "РЖД",
            companyLogo: Image(systemName: "tram.fill"),
            note: "Костроме",
            date: createDate(day: 14, hour: 0, minute: 0),
            departureTime: createDate(day: 14, hour: 22, minute: 30),
            arrivalTime: createDate(day: 15, hour: 8, minute: 15),
            duration: 20 * 3600
        ),
        TrainInfo(
            companyName: "ФГК",
            companyLogo: Image(systemName: "bolt.car.fill"),
            note: nil,
            date: createDate(day: 15, hour: 0, minute: 0),
            departureTime: createDate(day: 15, hour: 1, minute: 15),
            arrivalTime: createDate(day: 15, hour: 9, minute: 0),
            duration: 9 * 3600
        )
    ]
    
    return ListOfCarriersView(
        routeInfo: mockRouteInfo,
        trains: mockTrains
    )
}
