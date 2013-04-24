package com.playtune.snatris.gameStage {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    import com.playtune.snatris.entities.Gem;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.gameKit.utils.ScaleBitmap;

    import com.playtune.snatris.tiles.SxTile;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeSignal;

    public class GameGrid extends Sprite {

        public static const ROWS:uint = 12;
        public static const COLS:uint = 12;

        private var tiles:Vector.<Vector.<SxTile>> = new Vector.<Vector.<SxTile>>();

        private var clicked:NativeSignal;

        public function GameGrid() {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);

            for (var k:int = 0; k < ROWS; k++) {
                tiles[k] = new Vector.<SxTile>(COLS);
            }

            for (var i:uint = 0; i < ROWS; i++) {
                for (var j:uint = 0; j < COLS; j++) {
                    var tile:SxTile = createTile(i, j);
                    addChild(tile);

                    if (i < GameGrid.ROWS - 1 && j < GameGrid.COLS - 1) {
                        var cellDot:ScaleBitmap = new ScaleBitmap(ResourceManager.instance.getBitmapDataById(ImageResources.CELL_DOT.id));
                        //cellDot.width = 40;
                        //cellDot.height = 40;
                        cellDot.x = tile.x + tile.width - (cellDot.width >> 1);
                        cellDot.y = tile.y + tile.height - (cellDot.height >> 1);
                        addChild(cellDot);
                    }
                }
            }

            var border:ScaleBitmap = new ScaleBitmap(ResourceManager.instance.getBitmapDataById(ImageResources.BORDER.id));
            border.scale9Grid = new Rectangle(52, 52, 2, 2);
            border.width = SxTile.WIDTH * COLS + 46;
            border.height = SxTile.HEIGHT  * ROWS + 46;
            border.x = -23;
            border.y = -23;
            addChild(border);

            clicked = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
//            addEventListener(MouseEvent.CLICK, onClick);
            clicked.add(onClick);
        }

        private function createTile(row:uint, col:uint):SxTile {
            var tile:SxTile = new SxTile(row, col);
            tiles[row][col] = tile;

            tile.x = col * SxTile.WIDTH;
            tile.y = row * SxTile.HEIGHT;

            return tile;
        }

        public function getTile(row:uint, col:uint):SxTile {
            return tiles[row][col];
        }

        private function onClick(event:MouseEvent):void {
            var tile:SxTile = event.target as SxTile;
            if (tile) {
                var prob:Number = Math.random();
                tile.put(new Gem(prob >.6 ? GemColor.RED : prob > 0.3 ? GemColor.GREEN : GemColor.BLUE));
                //trace('row ', tile.row, 'col ', tile.col);
                //trace('isEqual: ', tile == getTile(tile.row, tile.col));
            }
        }
    }
}
