package {
    import flash.display.Sprite;
    import flash.text.TextField;

    public class Main extends Sprite {
        public function Main() {
            var text:TextField = new TextField();
            text.text = "Hello from Flex SonarQube example!";
            text.x = 10;
            text.y = 10;
            addChild(text);

            var result:Number = Helper.multiply(5, 3);
            trace("5 * 3 = " + result);
        }
    }
}
