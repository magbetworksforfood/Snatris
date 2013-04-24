package com.playtune.snatris.entities {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ResourceManager;

    public class Gem extends Sprite implements IEntity {

        public var gemType:GemColor;


        public function Gem(gemType:GemColor):void {
            this.gemType = gemType;

            init();
        }

        private function init():void {
            var bitmap:Bitmap = new Bitmap();
            bitmap.bitmapData = ResourceManager.instance.getBitmapDataById(GemFactory.getImageIdByType(gemType));

            addChild(bitmap);
        }

        public function get type():EntityType {
            return EntityType.GEM;
        }
    }
}
