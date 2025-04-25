//
//  StoriesHorizontalView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoriesHorizontalView: View {
    @Binding var stories: [Story]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach($stories) { $story in
                    StoryPreviewCellView(story: story)
                        .onTapGesture {
                            story.isViewed = true
                        }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
    }
}
