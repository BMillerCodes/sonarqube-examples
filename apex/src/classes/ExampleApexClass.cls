/**
 * @description This is an example Apex class for SonarQube analysis.
 */
public with sharing class ExampleApexClass {

    public static void unusedMethod() {
        // This method is unused and will be flagged by SonarQube.
    }

    public static Integer calculateSum(Integer a, Integer b) {
        // Avoid hardcoding values or using magic numbers. SonarQube will detect this.
        Integer result = a + b + 10; // 10 is a magic number
        return result;
    }

    public static void vulnerableMethod(String userInput) {
        // This is a simulated vulnerability. SonarQube should flag it.
        String query = 'SELECT Id FROM Account WHERE Name = ' + userInput;
        // Imagine this query is executed without proper sanitization/binding
        System.debug(query);
    }
}
