package com.playtune.snatris.snakeNew {
    import com.playtune.snatris.GameConstants;
    import com.playtune.snatris.tiles.SxTile;
    import flash.geom.Point;

    import starling.display.Sprite;


    public class SnakeSegment extends Sprite implements ISegment {

        protected var _prevNode:ISegment;
        protected var _nextNode:ISegment;
        protected var _endPoint:Point;
        protected var _startPoint:Point;
        public var currentTile:SxTile;

        public function SnakeSegment() {
        }

        public function set prevNode(node:ISegment):void {
            if (_prevNode != node) {
                _prevNode = node;
            }
        }

        public function set nextNode(node:ISegment):void {
            if (_nextNode != node) {
                _nextNode = node;
            }
        }

        public function get prevNode():ISegment {
            return _prevNode;
        }

        public function get nextNode():ISegment {
            return _nextNode;
        }

        public function update(time:Number):void {
            if (!_endPoint || !_startPoint) return;

            if (_startPoint.x != _endPoint.x || _startPoint.y != _endPoint.y) {
                const destination:Point = _endPoint;
                var startPos:Point = new Point(x, y);
                //const startPos:Point = _startPoint;


                const delta:Point = destination.subtract(startPos);

//                const angle:Number = Math.atan2(delta.y, delta.x);
//                const rotation:Number = angle * 180 / Math.PI;
                rotateChildren(angle);

                var progress:Number = time / GameConstants.GAME_SPEED;

                if (progress >= 1) {
                    _startPoint = _endPoint;
                    progress = 1;
                }

                var myNewLoc:Point = Point.interpolate(destination, startPos, progress);

                x = myNewLoc.x >> 0;
                y = myNewLoc.y >> 0;
                trace(y);
            }
        }

        public function get endPoint():Point {
            return _endPoint;
        }

        public function set endPoint(value:Point):void {
            if (_endPoint != value) {
                _endPoint = value;
            }
        }

        private var angle:Number = 0;

        public function moveTo(tile:SxTile):void {
            //чтобы змейка не складывалась
            if (tile == currentTile) {
                _startPoint = _endPoint;
                return
            }

            if (currentTile) {
                //currentTile ||= tile;
                //startPoint = _endPoint;

                startPoint = new Point(currentTile.x + (currentTile.width - this.width >> 1), currentTile.y + (currentTile.height - this.height >> 1));

                endPoint = new Point(tile.x + (tile.width - this.width >> 1), tile.y + (tile.height - this.height >> 1));

                //trace('endPoint', endPoint.x)



                if (_nextNode) {
                    _nextNode.moveTo(currentTile);
                }

                //angle
                const destination:Point = new Point(tile.col, tile.row);
                const startPos:Point = new Point(currentTile.col, currentTile.row);

                const delta:Point = destination.subtract(startPos);
                angle = Math.atan2(delta.y, delta.x);
            }


            currentTile = tile;
        }

        public function set startPoint(value:Point):void {
            if (_startPoint != value) {
                _startPoint = value;
                //trace('_startPoint', _startPoint.x);
            }
        }

        public function rotateChildren(angle:Number):void {

        }
    }
}
