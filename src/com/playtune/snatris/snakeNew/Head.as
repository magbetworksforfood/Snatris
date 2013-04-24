package com.playtune.snatris.snakeNew {
    import flash.geom.Matrix;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;
    import com.playtune.snatris.tiles.SxTile;

    public class Head extends SnakeSegment {

        private static const WIDTH:Number = 30;
        private static const HEIGHT:Number = 30;

        private var bmp:ScaleBitmap;

        public function Head():void {
            draw();
        }

        private function draw():void {
            /*graphics.clear();
            graphics.beginFill(0x39AECF);
            graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 5, 5);
            graphics.endFill();*/

            bmp = new ScaleBitmap(ResourceManager.instance.getBitmapDataById(ImageResources.HEAD.id));
            addChild(bmp);
        }

        override public function moveTo(tile:SxTile):void {

            /*if (collected) {
             collected.nextNode = segments.unshift(collected) > 1 ? segments[1] : _nextNode;
             addChild(collected);
             }*/


            super.moveTo(tile);

            //trace('head moveTo: ', tile.row, ' ', tile.col);

            /*var firstSeg:ISegment = getFirstChild();

            if (firstSeg) {
                firstSeg.moveTo(tile);
            } else {
                _nextNode.moveTo(tile);
            }*/
        }

        private var _angle:Number = 0;

        override public function rotateChildren(angle:Number):void {
            if (_angle != angle) {
                _angle = angle;
                var radians:Number = angle * (Math.PI / 180);
                trace(angle);
                var offsetWidth:Number = bmp.width >> 1;
                var offsetHeight:Number =  bmp.height >> 1;

                var matrix:Matrix = new Matrix();
                matrix.translate(-offsetWidth, -offsetHeight);
                matrix.rotate(radians);
                matrix.translate(+offsetWidth, +offsetHeight);
                //matrix.concat(bmp.transform.matrix);
                bmp.transform.matrix = matrix;
            }
        }

    }
}
