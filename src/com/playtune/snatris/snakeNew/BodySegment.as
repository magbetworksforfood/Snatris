package com.playtune.snatris.snakeNew {
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;

    import starling.display.Image;

    public class BodySegment extends SnakeSegment {

        private static const WIDTH:Number = 30;
        private static const HEIGHT:Number = 30;

        public function BodySegment(gemType:GemColor) {
            draw(gemType);
        }

        private function draw(gemType:GemColor):void {
            var resourceManager:ResourceManager = ResourceManager.instance;
            var bulb:Image = new Image(resourceManager.getTextureById(ImageResources.BODY.id));
            var gem:Image = new Image(resourceManager.getTextureById(GemFactory.getImageIdByType(gemType)));
            gem.height = bulb.height * .7;
            gem.width = bulb.width * .7;
            gem.x = bulb.width - gem.width >> 1;
            gem.y = bulb.height - gem.height >> 1;

            addChild(gem);
            addChild(bulb);
        }
    }
}
