package com.playtune.snatris.snakeNew {
    import com.greensock.TweenLite;
    import com.playtune.snatris.GameConstants;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import starling.display.Image;
    import starling.display.Sprite;

    public class BodySegment extends SnakeSegment {

        private static const WIDTH:Number = 30;
        private static const HEIGHT:Number = 30;

        private var segmentSprite:Sprite;

        public var gemType:GemColor;

        public function BodySegment(gemType:GemColor) {
            this.gemType = gemType;
            draw(gemType);
        }

        private function draw(gemType:GemColor):void {
            segmentSprite = new Sprite();
            addChild(segmentSprite);

            var resourceManager:ResourceManager = ResourceManager.instance;
            var bulb:Image = new Image(resourceManager.getTextureById(ImageResources.BODY.id));
            var gem:Image = new Image(resourceManager.getTextureById(GemFactory.getImageIdByType(gemType)));
            gem.height = bulb.height * .7;
            gem.width = bulb.width * .7;
            gem.x = bulb.width - gem.width >> 1;
            gem.y = bulb.height - gem.height >> 1;

            segmentSprite.addChild(gem);
            segmentSprite.addChild(bulb);
            segmentSprite.flatten();

            segmentSprite.pivotX = segmentSprite.width >> 1;
            segmentSprite.pivotY = segmentSprite.height >> 1;
            segmentSprite.x = segmentSprite.width >> 1;
            segmentSprite.y = segmentSprite.height >> 1;
        }

        override public function show(onComplete:Function):void {
            segmentSprite.alpha = 0;
            segmentSprite.scaleX = segmentSprite.scaleY = 0;

            TweenLite.to(segmentSprite,
                    GameConstants.GAME_SPEED *.001,
                    {
                        delay: GameConstants.GAME_SPEED *.001,
                        alpha: 1,
                        scaleX: 1,
                        scaleY: 1,
                        onComplete: onComplete
                    });
        }


        override public function hide(removeFromParent:Boolean = true):void {
            TweenLite.to(segmentSprite,
                    GameConstants.GAME_SPEED *.001,
                    {
                        //delay: GameConstants.GAME_SPEED *.001,
                        alpha: 0,
                        onComplete: removeFromParent ? SnakeBody(parent).removeSegment : null,
                        onCompleteParams: [this]
                    });
        }
    }
}
