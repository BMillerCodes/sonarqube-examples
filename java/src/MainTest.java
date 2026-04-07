public class MainTest {
    public static void main(String[] args) {
        int result = Calculator.add(2, 3);
        assert result == 5 : "Expected 5";
        System.out.println("All tests passed!");
    }
}