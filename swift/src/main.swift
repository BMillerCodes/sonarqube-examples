import Foundation

struct Calculator {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    static func divide(_ a: Int, _ b: Int) throws -> Int {
        guard b != 0 else {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }
}

enum CalculatorError: Error {
    case divisionByZero
}

func main() {
    print("Hello from Swift SonarQube example!")

    let result = Calculator.add(5, 3)
    print("5 + 3 = \(result)")

    do {
        let result = try Calculator.divide(10, 0)
        print("Result: \(result)")
    } catch CalculatorError.divisionByZero {
        print("Error: Division by zero")
    } catch {
        print("Error: \(error)")
    }
}

main()
