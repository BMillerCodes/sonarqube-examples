package {
    public class Helper {
        public static function multiply(a:Number, b:Number):Number {
            return a * b;
        }

        public static function isValid(value:Number):Boolean {
            return value >= 0 && value <= 100;
        }

        public static function formatMessage(message:String):String {
            return "[INFO] " + message;
        }
    }
}
