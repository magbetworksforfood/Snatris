package com.playtune.snatris.snakeNew {

    import com.playtune.snatris.tiles.SxTile;

    import starling.display.Sprite;

    public class SnakeBody extends SnakeSegment {

        private var segments:Vector.<ISegment> = new <ISegment>[];

        public function SnakeBody():void {
        }

        public function addSegment(segment:ISegment, from:SxTile):void {
            segment.nextNode = segments.unshift(segment) > 1 ? segments[1] : _nextNode;

            var segmentAsSprite:SnakeSegment = SnakeSegment(segment);

            segmentAsSprite.x = from.x + (from.width - Sprite(segment).width >> 1);
            segmentAsSprite.y = from.y + (from.height - Sprite(segment).height >> 1);

            addChild(segmentAsSprite);
        }

        private function getFirstChild():ISegment {
            return segments.length ? segments[0] : null;
        }

        override public function moveTo(tile:SxTile):void {

            var firstSeg:ISegment = getFirstChild();

            if (firstSeg) {
                firstSeg.moveTo(tile);
            } else {
                _nextNode.moveTo(tile);
            }
        }

        override public function update(time:Number):void {
            if (segments.length) {
                for each (var segment:ISegment in segments) {
                    segment.update(time);
                }
            } else {
                _nextNode.update(time);
            }
        }
    }
}
