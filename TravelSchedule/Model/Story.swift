//
//  StoryModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct Story: Identifiable, Hashable {
    let id = UUID()
    let small: ImageResource
    let title: String
    var isViewed: Bool
    let story: [ContentStory]
}
