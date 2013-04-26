package com.playtune.snatris.gameStage {
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.snatris.entities.Gem;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.snatris.tiles.SxTile;

    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;

    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class GameGrid extends Sprite {

        public static const ROWS:uint = 12;
        public static const COLS:uint = 12;

        private var topLayer:Sprite;
        private var bottomLayer:Sprite;

        private var tiles:Vector.<Vector.<SxTile>> = new Vector.<Vector.<SxTile>>();

        public function GameGrid() {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            topLayer = new Sprite();
            bottomLayer = new Sprite();

            addChild(bottomLayer);
            addChild(topLayer);

            var scaledTexture:Scale9Textures = new Scale9Textures(ResourceManager.instance.getTextureById(ImageResources.BORDER.id), new Rectangle(52, 52, 2, 2));
            var border:Scale9Image = new Scale9Image(scaledTexture);
            border.width = SxTile.WIDTH * COLS + 46;
            border.height = SxTile.HEIGHT  * ROWS + 46;
            border.x = -23;
            border.y = -23;
            topLayer.addChild(border);

            for (var k:int = 0; k < ROWS; k++) {
                tiles[k] = new Vector.<SxTile>(COLS);
            }

            for (var i:uint = 0; i < ROWS; i++) {
                for (var j:uint = 0; j < COLS; j++) {
                    var tile:SxTile = createTile(i, j);

                    if (i < GameGrid.ROWS - 1 && j < GameGrid.COLS - 1) {
                        var cellDot:Image = new Image(ResourceManager.instance.getTextureById(ImageResources.CELL_DOT.id));
                        cellDot.x = tile.x + tile.width - (cellDot.width >> 1);
                        cellDot.y = tile.y + tile.height - (cellDot.height >> 1);
                        topLayer.addChild(cellDot);
                    }

                    bottomLayer.addChild(tile);
                }
            }

            topLayer.flatten();

            /*var border:ScaleBitmap = new ScaleBitmap(ResourceManager.instance.getBitmapDataById(ImageResources.BORDER.id));
            border.scale9Grid = new Rectangle(52, 52, 2, 2);
            border.width = SxTile.WIDTH * COLS + 46;
            border.height = SxTile.HEIGHT  * ROWS + 46;
            border.x = -23;
            border.y = -23;*/


            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        private function createTile(row:uint, col:uint):SxTile {
            var tile:SxTile = new SxTile(row, col);
            tiles[row][col] = tile;

            tile.x = col * SxTile.WIDTH;
            tile.y = row * SxTile.HEIGHT;

            return tile;
        }

        public function getTile(row:uint, col:uint):SxTile {
            if (row >= ROWS || col >= COLS || row < 0 || col < 0) return null;
            return tiles[row][col];
        }



        private function onTouch(event:TouchEvent):void {
            var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
            if (touch) {
                var pos:Point = touch.getLocation(this);

                var tile:SxTile = getTile(Math.floor(pos.y / SxTile.HEIGHT), Math.floor(pos.x / SxTile.WIDTH));


                if (tile) {
                   // unflatten();
                    var prob:Number = Math.random();
                    tile.put(new Gem(prob >.6 ? GemColor.RED : prob > 0.3 ? GemColor.GREEN : GemColor.BLUE));
                    //trace('row ', tile.row, 'col ', tile.col);
                    //trace('isEqual: ', tile == getTile(tile.row, tile.col));
                    //flatten();
                }
            }
        }
    }
}
