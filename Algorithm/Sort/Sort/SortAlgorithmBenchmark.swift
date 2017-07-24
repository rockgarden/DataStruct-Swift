//
//  Jesse Squires
//  http://www.jessesquires.com
//
//  GitHub
//  https://github.com/jessesquires/swift-sorts
//
//  Copyright (c) 2014 Jesse Squires
//

import Foundation


class SortAlgorithmBenchmark {
    
    let algorithm: SortAlgorithm
    let closure: SortAlgorithmClosure
    var sortTimes = [Double]()
    
    init(_ algorithm: SortAlgorithm) {
        self.algorithm = algorithm
        self.closure = algorithm.closure
    }
    
    var name: String {
        return algorithm.rawValue + " sort"
    }
    
    var description: String {
        let avgTime = String(format: "%.6lf", averageSortTime())
        let stdDev = String(format: "%.6lf", standardDeviation())
        return "\(name): " + avgTime + " s (± " + stdDev + ")"
    }
    
    func sortArray(_ anArray: [Int]) -> Double {
        print("Running \(name)...")
        
        let startTime = Date()
        
        let sortedArray = algorithm.closure(anArray)
        
        let totalTime = startTime.timeIntervalSinceNow * -1
        
        assert(arrayIsSorted(sortedArray), "** Failed to sort! **")
        
        print("\(name) finished in \(totalTime) sec\n")
        
        sortTimes.append(totalTime)
        
        return totalTime
    }
    
    func averageSortTime() -> Double {
        return sortTimes.reduce(0.0, { $0 + $1 }) / Double(sortTimes.count)
    }
    
    func standardDeviation() -> Double {
        let avg = averageSortTime()
        
        let variance = sortTimes.map({ pow($0 - avg, 2.0) })
        
        let sum = variance.reduce(0.0, { $0 + $1 })
        
        let mean = sum / Double(variance.count)
        
        return sqrt(mean)
    }
    
}
