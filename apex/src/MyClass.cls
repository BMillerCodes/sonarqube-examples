/**
 * @description MyClass - Apex SonarQube Example
 */
public with sharing class MyClass {
    /**
     * @description Add two integers
     */
    public static Integer add(Integer a, Integer b) {
        return a + b;
    }

    /**
     * @description Divide two integers with error handling
     */
    public static Integer divide(Integer a, Integer b) {
        if (b == 0) {
            throw new ArithmeticException('Division by zero');
        }
        return a / b;
    }

    /**
     * @description Calculate with error handling
     */
    public static String calculateWithErrorHandling(Integer a, Integer b) {
        try {
            Integer result = divide(a, b);
            return 'Result: ' + result;
        } catch (ArithmeticException e) {
            return 'Error: ' + e.getMessage();
        }
    }
}
