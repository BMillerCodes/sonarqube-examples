import Foundation

struct Helper {
    static func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }

    static func isValid(_ value: Int) -> Bool {
        return value >= 0 && value <= 100
    }

    static func formatMessage(_ message: String) -> String {
        return "[INFO] \(message)"
    }
}
