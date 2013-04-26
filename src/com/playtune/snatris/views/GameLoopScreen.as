package com.playtune.snatris.views {
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;

    import com.playtune.snatris.controllers.GameTableController;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.snatris.gameStage.GameGrid;
    import com.playtune.snatris.snakeNew.Snake;
    import com.playtune.snatris.tiles.SxTile;

    import starling.display.Button;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class GameLoopScreen extends Sprite {

        private var controller:GameTableController;

        private var leftBtn:Button;
        private var rightBtn:Button;

        public function GameLoopScreen():void {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(event:Event):void {
            /*width = 500;
            height = 500;*/
            removeEventListener(Event.ADDED_TO_STAGE, init);

            var snake:Snake = new Snake();
            var gameGrid:GameGrid = new GameGrid();

            var tableContainer:Sprite = new Sprite();
            tableContainer.addChild(gameGrid);
            tableContainer.addChild(snake);
            addChild(tableContainer);

            var scale:Number = 1;
            tableContainer.scaleX = tableContainer.scaleY = scale;
            tableContainer.x = stage.stageWidth - tableContainer.width >> 1;
            tableContainer.y = stage.stageHeight - tableContainer.height >> 1;

            controller = new GameTableController(snake, gameGrid);

            leftBtn = new Button(ResourceManager.instance.getTextureById(GemFactory.getImageIdByType(GemColor.BLUE)))
            rightBtn = new Button(ResourceManager.instance.getTextureById(GemFactory.getImageIdByType(GemColor.RED)))
            leftBtn.y = rightBtn.y = 400;
            leftBtn.x = 10;
            rightBtn.x = stage.stageWidth - 220;
            leftBtn.width = 200;
            leftBtn.height = 200;
            leftBtn.alpha = .5;
            rightBtn.width = 200;
            rightBtn.height = 200;
            rightBtn.alpha = .5;

            addChild(leftBtn);
            addChild(rightBtn);

            leftBtn.addEventListener(TouchEvent.TOUCH, onLeftClick);
            rightBtn.addEventListener(TouchEvent.TOUCH, onRightClick);

            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            stage.addEventListener(TouchEvent.TOUCH, onMouseClick);
        }

        private function onMouseClick(event:TouchEvent):void {
            controller.start();
        }

        private function onEnterFrame(event:Event):void {
            controller.update();
        }

        private function onKeyDown(event:KeyboardEvent):void {
            switch (event.keyCode) {
                case Keyboard.LEFT:
                    controller.turnACW();
                    break;
                case Keyboard.RIGHT:
                    controller.turnCW();
                    break;
            }
        }

        private function onLeftClick(event:TouchEvent):void {
            var touch:Touch = event.getTouch(leftBtn, TouchPhase.BEGAN);
            if (touch) {
                controller.turnACW();
            }

        }

        private function onRightClick(event:TouchEvent):void {
            var touch:Touch = event.getTouch(rightBtn, TouchPhase.BEGAN);
            if (touch) {
                controller.turnCW();
            }
        }
    }
}
