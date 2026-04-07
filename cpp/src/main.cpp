#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
#include <memory>

class Calculator {
public:
    static int add(int a, int b) {
        return a + b;
    }

    static int divide(int a, int b) {
        if (b == 0) {
            throw std::invalid_argument("Division by zero");
        }
        return a / b;
    }
};

int main() {
    std::cout << "Hello from C++ SonarQube example!" << std::endl;

    int result = Calculator::add(5, 3);
    std::cout << "5 + 3 = " << result << std::endl;

    try {
        result = Calculator::divide(10, 0);
        std::cout << "Result: " << result << std::endl;
    } catch (const std::invalid_argument& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }

    std::vector<int> numbers = {1, 2, 3, 4, 5};
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    return 0;
}