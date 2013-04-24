package com.playtune.snatris.tiles {
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import com.playtune.snatris.entities.EntityType;

    import com.playtune.snatris.entities.IEntity;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;
    import com.playtune.snatris.gameStage.GameGrid;

    public class SxTile extends Sprite {

        private var _pivotX:int;
        private var _pivotY:int;

        public var row:uint;
        public var col:uint;

        public static const WIDTH:uint = 100;
        public static const HEIGHT:uint = 100;

        public var containedObject:IEntity;


        public function SxTile(row:uint, col:uint):void {
            this.row = row;
            this.col = col;

            draw();
        }

        public function draw():void {
            var bitmap:Bitmap = new Bitmap();
            bitmap.bitmapData = ResourceManager.instance.getBitmapDataById(ImageResources.CELL_BORDER.id);
            bitmap.width = WIDTH;
            bitmap.height = HEIGHT;
            addChild(bitmap);

            //graphics.beginFill(0xC9F76F);
            //graphics.lineStyle(1, 0xFFFFFF);
            //graphics.drawRect(0,0, WIDTH, HEIGHT);
        }

        public function get pivotX():int {
            return x >> 1;
        }

        public function get pivotY():int {
            return y >> 1;
        }

        public function containedObjectOfType(type:EntityType):Boolean {
            return containedObject ? containedObject.type == type : false;
        }

        public function put(entity:IEntity):void {
            addChild(entity as DisplayObject);
            containedObject = entity;
        }

        public function clear():void {
            if (containedObject) {
                removeChild(containedObject as DisplayObject);
                containedObject = null;
            }
        }

        public function get notEmpty():Boolean {
            return containedObject;
        }
    }
}
