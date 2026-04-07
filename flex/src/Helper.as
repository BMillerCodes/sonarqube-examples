package {
    public class Helper {
        public static function multiply(a:int, b:int):int {
            return a * b;
        }

        public static function isValid(value:int):Boolean {
            return value >= 0 && value <= 100;
        }

        public static function formatMessage(message:String):String {
            return "[INFO] " + message;
        }
    }
}
