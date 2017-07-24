//
//  Timeline.swift
//

import Foundation


public struct Timeline {

    public let startTime: CFAbsoluteTime

    public let latency: TimeInterval
    public let initialTime: TimeInterval
    public let completedTime: TimeInterval
    public let totalDuration: TimeInterval

    /// Creates a new `Timeline` instance with the specified run times.
    ///
    /// - returns: The new `Timeline` instance.
    public init(
        startTime: CFAbsoluteTime = 0.0,
        initialTime: CFAbsoluteTime = 0.0,
        completedTime: CFAbsoluteTime = 0.0)
    {
        self.startTime = startTime
        self.initialTime = initialTime
        self.completedTime = completedTime

        self.latency = initialTime - startTime
        self.totalDuration = completedTime - initialTime
    }
}

// MARK: - CustomStringConvertible

extension Timeline: CustomStringConvertible {

    public var description: String {
        let latency = String(format: "%.3f", self.latency)
        let totalDuration = String(format: "%.3f", self.totalDuration)

        let timings = [
            "\"Latency\": " + latency + " secs",
            "\"Total Duration\": " + totalDuration + " secs"
        ]

        return "Timeline: { " + timings.joined(separator: ", ") + " }"
    }
}

// MARK: - CustomDebugStringConvertible

extension Timeline: CustomDebugStringConvertible {

    public var debugDescription: String {
        let startTime = String(format: "%.3f", self.startTime)
        let initialTime = String(format: "%.3f", self.initialTime)
        let completedTime = String(format: "%.3f", self.completedTime)
        let latency = String(format: "%.3f", self.latency)
        let totalDuration = String(format: "%.3f", self.totalDuration)

        let timings = [
            "\"Start Time\": " + startTime,
            "\"Initial Time\": " + initialTime,
            "\"Completed Time\": " + completedTime,
            "\"Latency\": " + latency + " secs",
            "\"Total Duration\": " + totalDuration + " secs"
        ]

        return "Timeline: { " + timings.joined(separator: ", ") + " }"
    }
}
