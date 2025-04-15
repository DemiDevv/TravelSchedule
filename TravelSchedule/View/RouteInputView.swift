//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RouteInputView: View {
    @State private var fromCity: City?
    @State private var fromStation: Station?
    @State private var toCity: City?
    @State private var toStation: Station?
    
    @State private var isSelectingFrom = false
    @State private var isSelectingTo = false
    
    private var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    private func displayText(isFromField: Bool) -> String {
        let city = isFromField ? fromCity : toCity
        let station = isFromField ? fromStation : toStation
        let defaultText = isFromField ? "Откуда" : "Куда"
        
        guard let city = city else { return defaultText }
        guard let station = station else { return city.name }
        return "\(city.name) (\(station.name))"
    }
    
    private func textColor(isFromField: Bool) -> Color {
        let city = isFromField ? fromCity : toCity
        return city == nil ? .gray : .black
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
                    .frame(height: 130)
                
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Поле "Откуда"
                        Button(action: {
                            isSelectingFrom = true
                        }) {
                            Text(displayText(isFromField: true))
                                .foregroundColor(textColor(isFromField: true))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // Поле "Куда"
                        Button(action: {
                            isSelectingTo = true
                        }) {
                            Text(displayText(isFromField: false))
                                .foregroundColor(textColor(isFromField: false))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    
                    Button(action: {
                        swap(&fromCity, &toCity)
                        swap(&fromStation, &toStation)
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.blue)
                            .padding(12)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 10)
                }
            }
            
            if isSearchEnabled {
                Button(action: {
                    if let fromCity = fromCity, let fromStation = fromStation,
                       let toCity = toCity, let toStation = toStation {
                        print("Поиск маршрута от \(fromCity.name) (\(fromStation.name)) до \(toCity.name) (\(toStation.name))")
                    }
                }) {
                    Text("Найти")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 150, height: 60)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            Group {
                NavigationLink(
                    destination: ChoiceCityView(
                        selectedCity: $fromCity,
                        selectedStation: $fromStation
                    ),
                    isActive: $isSelectingFrom,
                    label: { EmptyView() }
                )
                
                NavigationLink(
                    destination: ChoiceCityView(
                        selectedCity: $toCity,
                        selectedStation: $toStation
                    ),
                    isActive: $isSelectingTo,
                    label: { EmptyView() }
                )
            }
        )
        .navigationBarBackButtonHidden(true)
        .onChange(of: fromStation) { _ in
            isSelectingFrom = false
        }
        .onChange(of: toStation) { _ in
            isSelectingTo = false
        }
    }
}
