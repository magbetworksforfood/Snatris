package com.playtune.gameKit.preloader {
    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;

    import com.playtune.gameKit.navigation.NavigatorController;

    public class Preloader extends Sprite implements IPreloader {

        [Embed(source="/com/playtune/gameKit/preloader/progress.png")]
        private var progressImg:Class;

        private var progressBar:Bitmap;

        private const BAR_WIDTH:uint = 150;
        private const BAR_HEIGHT:uint = 10;

        private const WIDTH:Number = 200;
        private const HEIGHT:Number = 30;

        private var _mask:Shape;

        private var _parent:DisplayObjectContainer;

        private var shape:Shape = new Shape();

        public var _opened:Boolean;

        public function Preloader():void {
            init();
        }


        private function init():void {
            progressBar = new progressImg;

            progressBar.width = BAR_WIDTH;
            progressBar.height = BAR_HEIGHT;


            shape.graphics.clear();
            shape.graphics.beginFill(0x000000, .8);
            shape.graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 10, 10);
            shape.graphics.endFill();

            addChild(shape);


            progressBar.cacheAsBitmap = true;
            progressBar.x = WIDTH - progressBar.width >> 1;
            progressBar.y = HEIGHT - progressBar.height >> 1;
            addChild(progressBar);

            _mask = new Shape();
            _mask.graphics.clear();
            _mask.graphics.beginFill(0x00FF00);
            _mask.graphics.drawRect(0, 0, progressBar.width, progressBar.height);

            _mask.graphics.endFill();
            _mask.cacheAsBitmap = true;
            _mask.x = progressBar.x;
            _mask.y = progressBar.y;
            addChild(_mask);

            progressBar.mask = _mask;
        }

        //todo: updatePosition move to NavigatorController
        private function updatePositions(width:Number,  height:Number):void {
            x = width - WIDTH >> 1;
            y = height - HEIGHT >> 1;
        }

        public function open(modal:Boolean = true):void {
            close();

            _opened = true;

            NavigatorController.instance.addPopUp(this, true);



/*            _parent = parent;

            //updatePositions(parent.width, parent.height);

            _parent.mouseEnabled = false;
            _parent.addChild(this);

            if (modal) {
                //stage.mouseEnabled = false;
            }*/

            _mask.width = 1;
        }

        public function progress(value:Number):void {
            _mask.width = progressBar.width * value;
        }

        public function close():void {
            _opened = false;

            NavigatorController.instance.removePopUp(this);
        }

        public function get opened():Boolean {
            return _opened;
        }
    }
}
