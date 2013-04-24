package com.playtune.gameKit.resources {
    public class ImageResources {

        //grid
        public static const BACKGROUND:ExternalResource = new ExternalResource('background', 'assets/back.png');
        public static const CELL_BORDER:ExternalResource = new ExternalResource('cell', 'assets/cell.png');
        public static const CELL_DOT:ExternalResource = new ExternalResource('cellDot', 'assets/cellDot.png');
        public static const BORDER:ExternalResource = new ExternalResource('outerFrame', 'assets/outerFrame.png');

        //gems
        public static const GEM_RED:ExternalResource = new ExternalResource('gemRed', 'assets/gemRed.png');
        public static const GEM_GREEN:ExternalResource = new ExternalResource('gemGreen', 'assets/gemGreen.png');
        public static const GEM_CYAN:ExternalResource = new ExternalResource('gemCyan', 'assets/gemCyan.png');
        public static const GEM_YELLOW:ExternalResource = new ExternalResource('gemYellow', 'assets/gemYellow.png');
        public static const GEM_ORANGE:ExternalResource = new ExternalResource('gemOrange', 'assets/gemOrange.png');
        public static const GEM_VIOLET:ExternalResource = new ExternalResource('gemViolet', 'assets/gemViolet.png');
        public static const GEM_BLUE:ExternalResource = new ExternalResource('gemBlue', 'assets/gemBlue.png');

        //snake
        public static const HEAD:ExternalResource = new ExternalResource('head', 'assets/snakeHead.png');
        public static const BODY:ExternalResource = new ExternalResource('body', 'assets/snakeBody.png');
        public static const TAIL:ExternalResource = new ExternalResource('tail', 'assets/snakeTail.png');

        public static const preload:Vector.<ExternalResource> = new <ExternalResource>[
            BACKGROUND,
            CELL_BORDER,
            CELL_DOT,
            BORDER,
            GEM_RED,
            GEM_GREEN,
            GEM_CYAN,
            GEM_YELLOW,
            GEM_ORANGE,
            GEM_VIOLET,
            GEM_BLUE,
            HEAD,
            BODY,
            TAIL
        ];

        public function ImageResources():void {
        }
    }
}
