package com.playtune.snatris.controllers {
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.getTimer;

    import com.playtune.snatris.GameConstants;

    import com.playtune.snatris.data.SxState;
    import com.playtune.snatris.gameStage.GameGrid;
    import com.playtune.snatris.snakeNew.Snake;
    import com.playtune.snatris.tiles.SxTile;

    public class GameTableController {
        private var snake:Snake;

        private var gameTable:GameGrid = new GameGrid();



        private static const CW:uint = 0x01;

        private static const ACW:uint = 0x10;

        private var state:SxState = SxState.PAUSED;

        private var prevTime:Number = 0;
        private var timeOnStep:Number = 0;

        private var moveLock:Boolean;

        private var direction:uint = 0;
                                  //1 - CLOCKWISE
                                  //2 - ANTICLOCKWISE
                                  //0 - STRAIGHT

        private var currentRow:int;
        private var currentCol:int;

        public function GameTableController(snake:Snake,  gameTable:GameGrid):void {
            this.snake = snake;
            this.gameTable = gameTable;
            init();
        }

        private function init():void {
            currentRow = 5;
            currentCol = 5;
            snake.placeAt(gameTable.getTile(currentRow, currentCol), gameTable.getTile(currentRow, currentCol - 1))
        }

        public function turnCW():void {
            direction = (direction & CW ? (direction ^ CW) : direction) | ACW;
        }

        public function turnACW():void {
            direction = (direction & ACW ? (direction ^ ACW) : direction) | CW;
        }

        public function update():void {
            if (state != SxState.RUNNIG) return;

            const currentTime:Number = getTimer();

            prevTime ||= currentTime;

            timeOnStep = currentTime - prevTime

            snake.update(timeOnStep);

            if (timeOnStep - GameConstants.GAME_SPEED > 0) {
                advanceTime();
                prevTime = currentTime;
            }
        }

        private function advanceTime():void {
            if (direction & CW) { //CW
                snake.direction += 90;
            } else if (direction & ACW) { //A0CW
                snake.direction -= 90;
            }

            if (snake.direction == 0) {
                currentCol++;
            } else if (snake.direction == 90 || snake.direction == -270) {
                currentRow--
            } else if (snake.direction == 180 || snake.direction == -180) {
                currentCol--;
            } else if (snake.direction == 270 || snake.direction == -90) {
                currentRow++
            }

            if (currentCol >= GameGrid.COLS) {
                currentCol = GameGrid.COLS - 1
            } else if (currentCol < 0) {
                currentCol = 0;
            }

            if (currentRow >= GameGrid.ROWS) {
                currentRow = GameGrid.ROWS - 1
            } else if (currentRow < 0) {
                currentRow = 0;
            }

            //var newBKLocOffset:Point = Point.polar(1, snake.direction * Math.PI / 180);

            var tile:SxTile = gameTable.getTile(currentRow, currentCol);

            snake.moveTo(tile);

            direction = 0;
        }

        public function start():void {
            state = SxState.RUNNIG;
        }

    }
}
