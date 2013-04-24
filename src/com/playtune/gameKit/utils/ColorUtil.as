package com.playtune.gameKit.utils {
    public class ColorUtil {

        public static function toRGB(hue:Number, saturation:Number, brightness:Number):uint {
            // Conversion taken from Foley, van Dam, et al
            var r:Number, g:Number, b:Number;
            if (saturation == 0) {
                r = g = b = brightness;
            }
            else {
                var h:Number = (hue % 360) / 60;
                var i:int = int(h);
                var f:Number = h - i;
                var p:Number = brightness * (1 - saturation);
                var q:Number = brightness * (1 - (saturation * f));
                var t:Number = brightness * (1 - (saturation * (1 - f)));
                switch (i) {
                    case 0:
                        r = brightness;
                        g = t;
                        b = p;
                        break;
                    case 1:
                        r = q;
                        g = brightness;
                        b = p;
                        break;
                    case 2:
                        r = p;
                        g = brightness;
                        b = t;
                        break;
                    case 3:
                        r = p;
                        g = q;
                        b = brightness;
                        break;
                    case 4:
                        r = t;
                        g = p;
                        b = brightness;
                        break;
                    case 5:
                        r = brightness;
                        g = p;
                        b = q;
                        break;
                }
            }
            r *= 255;
            g *= 255;
            b *= 255;
            return (r << 16 | g << 8 | b);
        }

        public static function getRandomColor(alpha:Number = 1):uint {
            return toRGB(Math.random() * 360,
                    Math.random() * 0.5 + 0.25,
                    Math.random() * 0.25 + 0.75) | (0xFF * alpha) << 24;
        }
    }
}
