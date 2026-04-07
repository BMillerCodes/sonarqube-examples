/**
 * @description Test class for MyClass
 */
@isTest
private class MyClassTest {
    @isTest
    static void testAdd() {
        Integer result = MyClass.add(2, 3);
        System.assertEquals(5, result, 'Expected 5');
    }

    @isTest
    static void testDivide() {
        Integer result = MyClass.divide(10, 2);
        System.assertEquals(5, result, 'Expected 5');
    }

    @isTest
    static void testDivideByZero() {
        try {
            MyClass.divide(1, 0);
            System.assert(false, 'Should have thrown exception');
        } catch (ArithmeticException e) {
            System.assertEquals('Division by zero', e.getMessage());
        }
    }

    @isTest
    static void testCalculateWithErrorHandling() {
        String result = MyClass.calculateWithErrorHandling(10, 2);
        System.assertEquals('Result: 5', result);

        result = MyClass.calculateWithErrorHandling(10, 0);
        System.assert(result.startsWith('Error:'));
    }
}
