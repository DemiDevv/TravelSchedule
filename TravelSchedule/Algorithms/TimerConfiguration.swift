//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import Foundation

struct TimerConfiguration {
    let storiesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.05
    ) {
        self.storiesCount = storiesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
