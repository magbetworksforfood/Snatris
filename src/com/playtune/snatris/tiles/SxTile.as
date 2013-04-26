package com.playtune.snatris.tiles {
    import com.playtune.snatris.entities.EntityType;

    import com.playtune.snatris.entities.IEntity;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;
    import com.playtune.snatris.gameStage.GameGrid;

    import flash.display.Bitmap;

    import starling.display.DisplayObject;
    import starling.display.Image;

    import starling.display.Sprite;
    import starling.textures.Texture;

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
//            var bitmap:Texture = new Texture();
//            bitmap.bitmapData = ResourceManager.instance.getBitmapDataById(ImageResources.CELL_BORDER.id);
            //bitmap.width = WIDTH;
            //bitmap.height = HEIGHT;

            var image:Image = new Image(ResourceManager.instance.getTextureById(ImageResources.CELL_BORDER.id));
            image.width = WIDTH;
            image.height = HEIGHT;
            addChild(image);

            //graphics.beginFill(0xC9F76F);
            //graphics.lineStyle(1, 0xFFFFFF);
            //graphics.drawRect(0,0, WIDTH, HEIGHT);
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
