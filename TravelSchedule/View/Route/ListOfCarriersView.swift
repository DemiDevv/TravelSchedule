//
//  ListOfCarriersView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    let routeInfo: RouteInfo
    @StateObject private var viewModel = ListOfCarriersViewModel()
    
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    @State private var showingDepartureTimeView = false
    @Environment(\.dismiss) private var dismiss
    
    private var routeTitle: String {
        let fromText = "\(routeInfo.fromStation?.name ?? "")"
        let toText = "\(routeInfo.toStation?.name ?? "")"
        return "\(fromText) → \(toText)"
    }
    
    var body: some View {
        ZStack {
            // Основной фон на весь экран
            Color(isDarkMode ? .blackYP : .white)
                .ignoresSafeArea()
            
            contentView
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showingDepartureTimeView) {
            DepartureTimeView(viewModel: viewModel)
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
        .onAppear {
            Task {
                await viewModel.loadCarriers(
                    fromStationCode: routeInfo.fromStation?.code ?? "",
                    toStationCode: routeInfo.toStation?.code ?? ""
                )
            }
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Заголовок с фиксированным позиционированием
            Text(routeTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .fixedSize(horizontal: false, vertical: true)
            
            // Контентная область
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 50)
                } else if viewModel.filteredCarriers.isEmpty {
                    VStack {
                        Spacer()
                        Text(viewModel.error == nil ? "Вариантов нет" : "Ошибка загрузки")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(isDarkMode ? .whiteYP : .black)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredCarriers) { carrier in
                                NavigationLink(destination: CarriersCardView(carrier: Carrier(
                                    name: carrier.carrierName,
                                    logoURL: carrier.carrierImage,
                                    email: carrier.carrierMail,
                                    phone: carrier.carrierPhone
                                ))) {
                                    TrainCellView(train: convertToTrainInfo(carrier: carrier))
                                }
                            }
                        }
                        .padding(.bottom, 16)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Кнопка внизу экрана
            Button(action: { showingDepartureTimeView = true }) {
                HStack(spacing: 8) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                    
                    if viewModel.hasActiveFilters {
                        Circle()
                            .fill(Color.redYP)
                            .frame(width: 8, height: 8)
                    }
                }
                .foregroundColor(.whiteYP)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.blueYP)
                .cornerRadius(16)
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func convertToTrainInfo(carrier: RouteCarrier) -> TrainInfo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let baseDate = Date()
        
        let departureComponents = carrier.routeStartTime.components(separatedBy: ":")
        let departureHour = Int(departureComponents.first ?? "0") ?? 0
        let departureMinute = Int(departureComponents.last ?? "0") ?? 0
        
        let durationHours = Int(carrier.routeDuration.components(separatedBy: " ").first ?? "0") ?? 0
        
        let departureDate = Calendar.current.date(
            bySettingHour: departureHour,
            minute: departureMinute,
            second: 0,
            of: baseDate
        ) ?? baseDate
        
        let arrivalDate = Calendar.current.date(
            byAdding: .hour,
            value: durationHours,
            to: departureDate
        ) ?? baseDate
        
        return TrainInfo(
            companyName: carrier.carrierName,
            companyLogoURL: carrier.carrierImage,
            note: carrier.transferInfo ? "С пересадкой" : nil,
            date: baseDate,
            departureTime: departureDate,
            arrivalTime: arrivalDate,
            duration: TimeInterval(durationHours * 3600)
        )
    }
}

//MARK: - Preview
#Preview {
    let moscow = City(name: "Москва", stations: [
        Station(name: "Киевский вокзал", code: "KV"),
        Station(name: "Курский вокзал", code: "KR"),
        Station(name: "Ярославский вокзал", code: "YAR")
    ])
    
    let petersburg = City(name: "Санкт-Петербург", stations: [
        Station(name: "Балтийский вокзал", code: "SPB-BAL"),
        Station(name: "Московский вокзал", code: "SPB-MOS"),
        Station(name: "Финляндский вокзал", code: "SPB-FIN")
    ])
    
    let routeInfo = RouteInfo(
        fromCity: moscow,
        fromStation: moscow.stations[0],
        toCity: petersburg,
        toStation: petersburg.stations[1]
    )
    
    return NavigationStack {
        ListOfCarriersView(routeInfo: routeInfo)
    }
}
