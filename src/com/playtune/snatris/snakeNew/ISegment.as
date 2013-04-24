package com.playtune.snatris.snakeNew {
    import flash.geom.Point;

    import com.playtune.snatris.tiles.SxTile;

    public interface ISegment {
        function set prevNode(node:ISegment):void
        function set nextNode(node:ISegment):void
        function get prevNode():ISegment
        function get nextNode():ISegment
        function get endPoint():Point;
        function set endPoint(value:Point):void
        function moveTo(tile:SxTile):void
        function update(time:Number):void
    }
}
