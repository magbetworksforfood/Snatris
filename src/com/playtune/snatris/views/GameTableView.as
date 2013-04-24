package com.playtune.snatris.views {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;

    import com.playtune.snatris.controllers.GameTableController;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.snatris.factories.GemFactory;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.snatris.gameStage.GameGrid;
    import com.playtune.snatris.snakeNew.Snake;
    import com.playtune.snatris.tiles.SxTile;

    public class GameTableView extends Sprite {

        private var controller:GameTableController;

        private var leftBtn:Sprite = new Sprite();
        private var rightBtn:Sprite = new Sprite();

        public function GameTableView():void {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(event:Event):void {
            var snake:Snake = new Snake();
            var gameGrid:GameGrid = new GameGrid();

            var tableContainer:Sprite = new Sprite();
            tableContainer.addChild(gameGrid);
            tableContainer.addChild(snake);
            var scale:Number = 1;
            tableContainer.scaleX = tableContainer.scaleY = scale;
            tableContainer.x = stage.stageWidth - (GameGrid.COLS * SxTile.WIDTH * scale) >> 1;
            tableContainer.y = 50/*stage.stageHeight - 15*52 >> 1*/;

            addChild(tableContainer);

            controller = new GameTableController(snake, gameGrid);

            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            stage.addEventListener(MouseEvent.CLICK, onMouseClick);


            leftBtn.y = rightBtn.y = 500;
            leftBtn.x = 50;
            rightBtn.x = stage.stageWidth - 250;

            var bitmap:Bitmap = new Bitmap();
            bitmap.bitmapData = ResourceManager.instance.getBitmapDataById(GemFactory.getImageIdByType(GemColor.BLUE));
            leftBtn.addChild(bitmap);
            leftBtn.width = 200;
            leftBtn.height = 200;

            var bitmap2:Bitmap = new Bitmap();
            bitmap2.bitmapData = ResourceManager.instance.getBitmapDataById(GemFactory.getImageIdByType(GemColor.RED));
            rightBtn.addChild(bitmap2);
            rightBtn.width = 200;
            rightBtn.height = 200;

            addChild(leftBtn);
            addChild(rightBtn);

            leftBtn.addEventListener(MouseEvent.CLICK, onLeftClick);
            rightBtn.addEventListener(MouseEvent.CLICK, onRightClick);
        }

        private function onMouseClick(event:MouseEvent):void {
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

        private function onLeftClick(event:MouseEvent):void {
            controller.turnACW();
        }

        private function onRightClick(event:MouseEvent):void {
            controller.turnCW();
        }
    }
}
