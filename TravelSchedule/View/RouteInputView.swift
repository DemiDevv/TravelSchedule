//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RouteInputView: View {
    @StateObject private var viewModel = RouteInputViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Блок ввода маршрута
            routeInputBlock
            
            // Кнопка поиска
            if viewModel.isSearchEnabled {
                searchButton
            }
            
            Spacer()
        }
        .padding()
        .background(navigationLinks)
        .navigationBarBackButtonHidden(true)
        .onChange(of: viewModel.from) { _ in
            viewModel.resetSelection(for: .from)
        }
        .onChange(of: viewModel.to) { _ in
            viewModel.resetSelection(for: .to)
        }
    }
    
    // MARK: - Subviews
    
    private var routeInputBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .frame(height: 130)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    // Поле "Откуда"
                    stationButton(
                        text: viewModel.from.displayName,
                        textColor: viewModel.textColor(for: viewModel.from),
                        action: { viewModel.isSelectingFrom = true }
                    )
                    
                    // Поле "Куда"
                    stationButton(
                        text: viewModel.to.displayName,
                        textColor: viewModel.textColor(for: viewModel.to),
                        action: { viewModel.isSelectingTo = true }
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                // Кнопка смены мест
                Button(action: viewModel.swapStations) {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 10)
            }
        }
    }
    
    private func stationButton(text: String, textColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(textColor)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var searchButton: some View {
        Button(action: viewModel.performSearch) {
            Text("Найти")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 150, height: 60)
                .background(Color.blue)
                .cornerRadius(16)
        }
    }
    
    private var navigationLinks: some View {
        Group {
            NavigationLink(
                destination: ChoiceCityView(selected: $viewModel.from),
                isActive: $viewModel.isSelectingFrom,
                label: { EmptyView() }
            )
            
            NavigationLink(
                destination: ChoiceCityView(selected: $viewModel.to),
                isActive: $viewModel.isSelectingTo,
                label: { EmptyView() }
            )
        }
    }
}

struct RouteInputView_Previews: PreviewProvider {
    static var previews: some View {
        RouteInputView()
    }
}
