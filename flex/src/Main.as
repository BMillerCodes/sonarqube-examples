package {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.events.Event;

    public class Main extends Sprite {
        private var greeting:TextField;

        public function Main() {
            greeting = new TextField();
            greeting.text = "Hello from Flex/ActionScript SonarQube example!";
            greeting.x = 10;
            greeting.y = 10;
            greeting.width = 300;
            addChild(greeting);

            var calc:Calculator = new Calculator();
            var result:int = calc.add(5, 3);
            greeting.text += "\n5 + 3 = " + result;

            try {
                calc.divide(10, 0);
            } catch (e:Error) {
                greeting.text += "\nError: " + e.message;
            }
        }
    }
}

class Calculator {
    public function add(a:int, b:int):int {
        return a + b;
    }

    public function divide(a:int, b:int):int {
        if (b == 0) {
            throw new Error("Division by zero");
        }
        return a / b;
    }
}
