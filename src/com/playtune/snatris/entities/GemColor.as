package com.playtune.snatris.entities {
    import com.playtune.gameKit.data.Enum;

    public class GemColor extends Enum {

        public static const RED:GemColor = new GemColor('red');
        public static const GREEN:GemColor = new GemColor('green');
        public static const BLUE:GemColor = new GemColor('blue');
        public static const ORANGE:GemColor = new GemColor('orange');
        public static const YELLOW:GemColor = new GemColor('yellow');
        public static const VIOLET:GemColor = new GemColor('violet');
        public static const CYAN:GemColor = new GemColor('cian');

        public function GemColor(id:String):void {
            super(id);
        }
    }
}
