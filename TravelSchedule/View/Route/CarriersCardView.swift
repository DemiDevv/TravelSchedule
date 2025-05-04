//
//  CarriersCardView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct CarriersCardView: View {
    let carrier: Carrier
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var backgroundColor: Color {
        isDarkMode ? Color.blackYP : Color.white
    }
    
    private var textColor: Color {
        isDarkMode ? Color.whiteYP : Color.blackYP
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if !carrier.logoURL.isEmpty, let url = URL(string: carrier.logoURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 64)
                            .padding(20)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 64)
                            .padding(20)
                    }
                    .frame(maxWidth: .infinity, minHeight: 104)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(carrier.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(textColor)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("E-mail")
                                .font(.system(size: 17))
                                .foregroundColor(textColor)
                            Link(carrier.email, destination: URL(string: "mailto:\(carrier.email)")!)
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Телефон")
                                .font(.system(size: 17))
                                .foregroundColor(textColor)
                            Link(carrier.phone, destination: URL(string: "tel:\(carrier.phone.filter { $0.isNumber || $0 == "+" })")!)
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(16)
                
                Spacer()
            }
        }
        .background(backgroundColor)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
