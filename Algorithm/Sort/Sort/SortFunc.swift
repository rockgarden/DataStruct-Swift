//
//  Jesse Squires
//  http://www.jessesquires.com
//
//  GitHub
//  https://github.com/jessesquires/swift-sorts
//

typealias SortAlgorithmClosure = (_ arr: [Int]) -> [Int]

enum SortAlgorithm : String {

    case swift = "Swift"
    case quick = "Quick"
    case heap = "Heap"
    case insertion = "Insertion"
    case selection = "Selection"

    var closure: SortAlgorithmClosure {
        switch self {
        case .swift:
            return SortFunc.swiftSort
        case .quick:
            return SortFunc.quickSort
        case .heap:
            return SortFunc.heapSort
        case .insertion:
            return SortFunc.insertionSort
        case .selection:
            return SortFunc.selectionSort
        }
    }
}

struct SortFunc {

    static func swiftSort(_ arr: [Int]) -> [Int]
    {
        return arr.sorted()
    }

    static func selectionSort(_ array: [Int]) -> [Int]
    {
        var arr = array
        var minIndex = 0

        for i in 0..<arr.count {
            minIndex = i

            for j in (i + 1)..<arr.count {
                if arr[j] < arr[minIndex] {
                    minIndex = j
                }
            }

            if (minIndex != i) {
                swap(&arr[i], &arr[minIndex])
            }
        }
        return arr;
    }

    static func insertionSort(_ array: [Int]) -> [Int]
    {
        var arr = array
        for i in 1..<arr.count {
            var j = i
            let target = arr[i]

            while j > 0 && target < arr[j - 1] {
                swap(&arr[j], &arr[j - 1])
                j -= 1
            }
            arr[j] = target
        }

        return arr;
    }

    static func quickSort(_ array: [Int]) -> [Int]
    {
        var arr = array
        quickSort(&arr, left: 0, right: arr.count - 1)
        return arr;
    }

    static private func quickSort(_ arr: inout [Int], left: Int, right: Int)
    {
        let index = partition(&arr, left: left, right: right)

        if left < index - 1 {
            quickSort(&arr, left: left, right: index - 1)
        }

        if index < right {
            quickSort(&arr, left: index, right: right)
        }
    }

    static private func partition(_ arr: inout [Int], left: Int, right: Int) -> Int
    {
        var i = left
        var j = right
        let pivot = arr[(left + right) / 2]

        while i <= j {
            while arr[i] < pivot {
                i += 1
            }

            while j > 0 && arr[j] > pivot {
                j -= 1
            }

            if i <= j {
                if i != j {
                    swap(&arr[i], &arr[j])
                }
                i += 1

                if j > 0 {
                    j -= 1
                }
            }
        }
        return i
    }

    static func heapSort(_ array: [Int]) -> [Int]
    {
        var arr = array
        heapify(&arr, count: arr.count)

        var end = arr.count - 1

        while end > 0 {
            swap(&arr[end], &arr[0])
            siftDown(&arr, start: 0, end: end - 1)
            end -= 1
        }

        return arr;
    }

    static private func heapify(_ arr: inout [Int], count: Int)
    {
        var start = (count - 2) / 2

        while start >= 0 {
            siftDown(&arr, start: start, end: count - 1)
            start -= 1
        }
    }
    
    static private func siftDown(_ arr: inout [Int], start: Int, end: Int)
    {
        var root = start
        
        while root * 2 + 1 <= end {
            var child = root * 2 + 1
            
            if child + 1 <= end && arr[child] < arr[child + 1] {
                child += 1
            }
            
            if arr[root] < arr[child] {
                swap(&arr[root], &arr[child])
                root = child
            }
            else {
                return
            }
        }
    }

}
