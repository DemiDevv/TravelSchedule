//
//  SplashView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 20.04.2025.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        SplashScreen(isActive: $isActive)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(true))
    }
}
