package com.playtune.snatris.snakeNew {
    import com.playtune.snatris.entities.EntityType;
    import com.playtune.snatris.entities.Gem;
    import com.playtune.snatris.tiles.SxTile;

    import flash.display.Sprite;

    import com.playtune.gameKit.utils.ColorUtil;

    public class Snake extends Sprite {
        private var segments:Vector.<ISegment> = new <ISegment>[];

        private var head:SnakeSegment;
        private var tail:SnakeSegment;
        private var body:SnakeBody;

        private var _direction:Number = 0;

        public function Snake():void {
            init();
        }

        private function init():void {
            head = new Head();
            tail = new Tail();
            body = new SnakeBody();
            head.nextNode = body;
            body.nextNode = tail;
            body.prevNode = head;
            //body.addSegment(new BodySegment(ColorUtil.getRandomColor()));

            segments.push(head);
            segments.push(body);
            segments.push(tail);

            addChild(tail);
            addChild(body);
            addChild(head);

        }


        public function update(time:Number):void {
            for each (var seg:SnakeSegment in segments) {
                seg.update(time);
            }
        }

        public function moveTo(tile:SxTile):void {
            head.moveTo(tile);

            if (tile.notEmpty) {
                if (tile.containedObjectOfType(EntityType.GEM)) {
                    var gem:Gem = tile.containedObject as Gem;
                    body.addSegment(new BodySegment(gem.gemType), tile);
                    tile.clear();
                }
            }


        }


        public function get direction():Number {
            return _direction;
        }

        public function set direction(value:Number):void {
            if (_direction != value) {
                _direction = value % 360;
            }
        }

        public function placeAt(headTile:SxTile, tailTile:SxTile):void {
            head.x = headTile.x + (headTile.width - head.width >> 1);
            head.y = headTile.y + (headTile.height - head.height >> 1);
            head.currentTile = headTile;
            tail.x = tailTile.x + (tailTile.width - tail.width >> 1);
            tail.y = tailTile.y + (tailTile.height - tail.height >> 1);
            tail.currentTile = tailTile;

            //moveTo(tile);
        }
    }
}
