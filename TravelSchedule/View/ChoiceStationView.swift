//
//  ChoiceStationView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct ChoiceStationView: View {
    let city: String
    @Binding var selected: CityStation
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ChoiceStationViewModel
    
    init(city: String, selected: Binding<CityStation>) {
        self.city = city
        self._selected = selected
        self._viewModel = StateObject(wrappedValue: ChoiceStationViewModel(city: city))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Кастомная поисковая строка
            SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
            
            // Основное содержимое
            if viewModel.filteredStations.isEmpty && !viewModel.searchText.isEmpty {
                // Сообщение, если ничего не найдено
                VStack {
                    Spacer()
                    Text("Станция не найдена")
                        .font(.system(size: 24))
                        .foregroundColor(.blackYP)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                // Список станций
                List {
                    ForEach(viewModel.filteredStations, id: \.self) { station in
                        Button(action: {
                            viewModel.selectStation(station) { selection in
                                selected = selection
                                dismiss()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            RowView(title: station)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color.white)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
        .onChange(of: viewModel.searchText) { _ in
            viewModel.updateSearchingState()
        }
    }
}

struct ChoiceStationView_Previews: PreviewProvider {
    @State static var selected = CityStation(city: "Москва", station: nil)

    static var previews: some View {
        NavigationView {
            ChoiceStationView(city: "Москва", selected: $selected)
        }
    }
}
