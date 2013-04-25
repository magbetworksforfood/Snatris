package com.playtune.snatris.entities {
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ResourceManager;

    import starling.display.Image;

    import starling.display.Sprite;

    public class Gem extends Sprite implements IEntity {

        public var gemType:GemColor;


        public function Gem(gemType:GemColor):void {
            this.gemType = gemType;

            init();
        }

        private function init():void {
            addChild(new Image(ResourceManager.instance.getTextureById(GemFactory.getImageIdByType(gemType))));
        }

        public function get type():EntityType {
            return EntityType.GEM;
        }
    }
}
