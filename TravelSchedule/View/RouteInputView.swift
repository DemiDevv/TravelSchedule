//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RouteInputView: View {
    @State private var from: CityStation = CityStation(city: "Откуда")
    @State private var to: CityStation = CityStation(city: "Куда")
    @State private var isSelectingFrom = false
    @State private var isSelectingTo = false
    
    // Вычисляемое свойство для проверки, заполнены ли оба поля
    private var isSearchEnabled: Bool {
        from.city != "Откуда" && to.city != "Куда"
    }
    
    // Вычисляемое свойство для определения цвета текста
    private func textColor(for field: CityStation) -> Color {
        field.city == "Откуда" || field.city == "Куда" ? .gray : .black
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
                        // Откуда
                        Button(action: {
                            isSelectingFrom = true
                        }) {
                            Text(from.displayName)
                                .foregroundColor(textColor(for: from))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // Куда
                        Button(action: {
                            isSelectingTo = true
                        }) {
                            Text(to.displayName)
                                .foregroundColor(textColor(for: to))
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
                    
                    // Иконка смены мест
                    Button(action: {
                        swap(&from, &to)
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
            
            // Кнопка "Найти" показывается только когда оба поля заполнены
            if isSearchEnabled {
                Button(action: {
                    print("Поиск маршрута от \(from.displayName) до \(to.displayName)")
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
                    destination: ChoiceCityView(selected: $from),
                    isActive: $isSelectingFrom,
                    label: { EmptyView() }
                )
                
                NavigationLink(
                    destination: ChoiceCityView(selected: $to),
                    isActive: $isSelectingTo,
                    label: { EmptyView() }
                )
            }
        )
        .navigationBarBackButtonHidden(true)
        .onChange(of: from) { _ in
            isSelectingFrom = false
        }
        .onChange(of: to) { _ in
            isSelectingTo = false
        }
    }
}
