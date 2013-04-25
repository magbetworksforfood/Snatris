package com.playtune.snatris.snakeNew {
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;

    import starling.display.Image;
    import starling.utils.deg2rad;

    public class Tail extends SnakeSegment {

        private static const WIDTH:Number = 25;
        private static const HEIGHT:Number = 25;

        private var tailImg:Image;

        public function Tail():void {
            draw();
        }

        private var bmp:ScaleBitmap;

        private function draw():void {
            /*graphics.clear();
             graphics.beginFill(0xA60C00);
             graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 5, 5);
             graphics.endFill();*/

//            bmp = new ScaleBitmap(ResourceManager.instance.getBitmapDataById(ImageResources.TAIL.id))
            tailImg = new Image(ResourceManager.instance.getTextureById(ImageResources.TAIL.id));
            tailImg.x = tailImg.width >> 1;
            tailImg.y = tailImg.height >> 1;
            tailImg.pivotX = tailImg.width >> 1;
            tailImg.pivotY = tailImg.height >> 1;
            addChild(tailImg);
        }


        private var _angle:Number = 0;

        override public function rotateChildren(angle:Number):void {
            if (_angle != angle) {
                _angle = angle;
                tailImg.rotation = angle//deg2rad(angle);
                /*var radians:Number = angle * (Math.PI / 180);
                trace(angle);
                var offsetWidth:Number = bmp.width >> 1;
                var offsetHeight:Number =  bmp.height >> 1;

                var matrix:Matrix = new Matrix();
                matrix.translate(-offsetWidth, -offsetHeight);
                matrix.rotate(radians);
                matrix.translate(+offsetWidth, +offsetHeight);
                //matrix.concat(bmp.transform.matrix);
                bmp.transform.matrix = matrix;*/
            }
        }
    }
}
