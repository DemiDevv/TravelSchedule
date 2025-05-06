//
//  TrainCellView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct TrainCellView: View {
    let train: TrainInfo
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private func formatDuration(_ interval: TimeInterval) -> String {
        let hours = Int(interval.rounded(.toNearestOrAwayFromZero)) / 3600
        return "\(hours) часов"
    }
    
    var body: some View {
        ZStack {
            Color.lightGrayYP
            
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    Group {
                        if let urlString = train.companyLogoURL, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 38, height: 38)
                            }
                        } else {
                            Image(systemName: "tram.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                                .foregroundColor(isDarkMode ? .blackYP : .primary)
                        }
                    }
                    .frame(width: 38, height: 38)
                    .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(train.companyName)
                                .font(.system(size: 17))
                                .foregroundColor(isDarkMode ? .blackYP : .primary)
                            
                            Spacer()
                            
                            Text(dateFormatter.string(from: train.date))
                                .font(.system(size: 12))
                                .foregroundColor(isDarkMode ? .blackYP : .secondary)
                        }
                        
                        if let note = train.note {
                            Text(note)
                                .font(.system(size: 12))
                                .foregroundColor(.redYP)
                        }
                    }
                    .padding(.trailing, 8)
                }
                
                HStack {
                    Text(timeFormatter.string(from: train.departureTime))
                        .font(.system(size: 17))
                        .foregroundColor(isDarkMode ? .blackYP : .primary)
                    
                    Rectangle()
                        .fill(isDarkMode ? Color.gray : Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)
                    
                    Text(formatDuration(train.duration))
                        .font(.system(size: 12))
                        .foregroundColor(.blackYP)
                    
                    Rectangle()
                        .fill(isDarkMode ? Color.gray : Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)
                    
                    Text(timeFormatter.string(from: train.arrivalTime))
                        .font(.system(size: 17))
                        .foregroundColor(isDarkMode ? .blackYP : .primary)
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .frame(height: 104)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//MARK: - Preview
#Preview {
    Group {
        TrainCellView(train: TrainInfo(
            companyName: "РЖД",
            companyLogoURL: "https://example.com/logo.png",
            note: "С пересадкой",
            date: Date(),
            departureTime: Date(),
            arrivalTime: Date().addingTimeInterval(3600 * 4),
            duration: 3600 * 4
        ))
        .padding()
        
        TrainCellView(train: TrainInfo(
            companyName: "Аэроэкспресс",
            companyLogoURL: nil,
            note: nil,
            date: Date(),
            departureTime: Date(),
            arrivalTime: Date().addingTimeInterval(3600 * 2),
            duration: 3600 * 2
        ))
        .padding()
        .preferredColorScheme(.light)
    }
}
