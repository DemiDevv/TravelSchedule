//
//  ContentStoryModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct ContentStory: Identifiable, Hashable {
    let id = UUID()
    let big: ImageResource
    let title: String
    let description: String
}
