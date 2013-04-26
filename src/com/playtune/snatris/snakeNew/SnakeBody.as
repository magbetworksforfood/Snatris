package com.playtune.snatris.snakeNew {

    import com.playtune.snatris.entities.GemColor;
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

            segmentAsSprite.show(checkSameColors);
            addChild(segmentAsSprite);
        }

        public static const DELETE_COUNT:uint = 3;


        //todo complete, fix
        private function checkSameColors():void {
            var prevColor:GemColor;
            var itemsToDelete:Vector.<BodySegment> = new <BodySegment>[];

            const length:uint = segments.length;
            for (var i:uint = 0; i < length; i++) {
                var segment:BodySegment = BodySegment(segments[i]);
                var currentColor:GemColor = segment.gemType;
                if (currentColor != prevColor) {
                    itemsToDelete = new  <BodySegment>[];
                }

                itemsToDelete.push(segment);

                prevColor = currentColor;

                const deleteLength:uint = itemsToDelete.length;
                if (deleteLength >= DELETE_COUNT) {
                    for (var j:int = 0; j < deleteLength; j++) {
                        var deleteSegment:ISegment = itemsToDelete[j];
                        /*var index:int = segments.indexOf(deleteSegment);
                        if (index != -1) {
                            segments.splice(index, 1);
                        }*/
                        SnakeSegment(deleteSegment).hide();
                        //removeChild(SnakeSegment(deleteSegment));
                    }

                    break;
                }
            }
        }

        public function removeSegment(segment:ISegment):void {
            var index:int = segments.indexOf(segment);
            if (index != -1) {
                segments.splice(index, 1);
            }

            index = getChildIndex(BodySegment(segment));
            if (index != -1) {
                removeChildAt(index);
            }
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
